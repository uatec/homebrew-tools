require "download_strategy"
require "net/http"
require "json"

class PrivateGitHubDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
  end

  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end

    _, @owner, @repo, @tag, @filename = *@url.match(url_pattern)
  end

  def download_url
    uri = URI("https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}")
    req = Net::HTTP::Get.new(uri)
    req["Accept"] = "application/octet-stream"
    req["Authorization"] = "Bearer #{github_token}"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    res["location"]
  end

  private

  def _fetch(url:, resolved_url:, timeout:)
    # HTTP request header `Accept: application/octet-stream` is required.
    # Without this, the GitHub API will respond with metadata, not binary.
    curl_download download_url, "--header", "Accept: application/octet-stream", to: temporary_path
  end

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    release_metadata = fetch_release_metadata
    assets = release_metadata["assets"].select { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset file not found." if assets.empty?

    assets.first["id"]
  end

  def fetch_release_metadata
    release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    uri = URI(release_url)
    req = Net::HTTP::Get.new(uri)
    req["Accept"] = "application/vnd.github+json"
    req["Authorization"] = "Bearer #{github_token}"
    req["X-GitHub-Api-Version"] = "2022-11-28"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else
      raise CurlDownloadStrategyError, "Failed to fetch release metadata: #{res.code} #{res.message}"
    end
  rescue StandardError => e
    raise CurlDownloadStrategyError, "Failed to fetch release metadata: #{e.message}"
  end

  def github_token
    @github_token ||= begin
      # Retrieve the token from the macOS Keychain
      token = `security find-generic-password -s "uatec-homebrew-tools-github-token" -w 2>/dev/null`.strip
      if token.empty?
        raise CurlDownloadStrategyError, "No GitHub API token found in Keychain. Run `secure-tap-access` to set it up."
      end
      token
    end
  end
end
