require "download_strategy"
require "net/http"
require "json"

class PrivateGitHubDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
  end

  def parse_url_pattern
    release_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    tarball_pattern = %r{https://github.com/([^/]+)/([^/]+)/archive/refs/tags/([^/]+)\.tar\.gz}
    zipball_pattern = %r{https://github.com/([^/]+)/([^/]+)/archive/refs/tags/([^/]+)\.zip}

    if (m = @url.match(release_pattern))
      @source_kind = :release_asset
      _, @owner, @repo, @tag, @filename = *m
    elsif (m = @url.match(tarball_pattern))
      @source_kind = :tarball
      _, @owner, @repo, @tag = *m
    elsif (m = @url.match(zipball_pattern))
      @source_kind = :zipball
      _, @owner, @repo, @tag = *m
    else
      raise CurlDownloadStrategyError,
            "Invalid url pattern: expected /releases/download/<tag>/<file> or /archive/refs/tags/<tag>.{tar.gz,zip}."
    end
  end

  def download_url
    case @source_kind
    when :release_asset
      resolve_redirect(URI("https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"),
                       accept: "application/octet-stream")
    when :tarball
      resolve_redirect(URI("https://api.github.com/repos/#{@owner}/#{@repo}/tarball/#{@tag}"))
    when :zipball
      resolve_redirect(URI("https://api.github.com/repos/#{@owner}/#{@repo}/zipball/#{@tag}"))
    end
  rescue StandardError => e
    raise CurlDownloadStrategyError, "Failed to get download URL: #{e.message}"
  end

  def resolve_redirect(uri, accept: nil)
    req = Net::HTTP::Get.new(uri)
    req["Accept"] = accept if accept
    req["Authorization"] = "Bearer #{github_token}"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    if res["location"]
      res["location"]
    else
      raise CurlDownloadStrategyError, "Failed to get download URL: #{res.code} #{res.message}"
    end
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

    unless res.is_a?(Net::HTTPSuccess)
      raise CurlDownloadStrategyError, "GitHub API request failed: #{res.code} #{res.message}"
    end

    JSON.parse(res.body)
  rescue JSON::ParserError => e
    raise CurlDownloadStrategyError, "Failed to parse GitHub API response: #{e.message}"
  rescue StandardError => e
    raise CurlDownloadStrategyError, "Failed to fetch release metadata: #{e.message}"
  end

    def github_token
    @github_token ||= begin
      # 1. Environment variable
      return ENV["UATEC_HOMEBREW_TOOLS_GITHUB_TOKEN"] if ENV["UATEC_HOMEBREW_TOOLS_GITHUB_TOKEN"]

      # 2. Local file (Linux/Fallback)
      token_file = File.expand_path("~/.config/uatec-homebrew-tools/token")
      if File.exist?(token_file)
        token = File.read(token_file).strip
        return token unless token.empty?
      end

      # 3. macOS Keychain (macOS only)
      if OS.mac?
        token = `security find-generic-password -s "uatec-homebrew-tools-github-token" -w 2>/dev/null`.strip
        return token unless token.empty?
      end

      raise CurlDownloadStrategyError, "No GitHub API token found. Please set UATEC_HOMEBREW_TOOLS_GITHUB_TOKEN, or run `secure-tap-access`."
    end
  end
end
