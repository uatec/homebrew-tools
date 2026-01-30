require "download_strategy"

class PrivateGitHubDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
  end

  def _curl_args
    super + ["--header", "Authorization: token #{github_token}"]
  end

  private

  def github_token
    @github_token ||= begin
      # Retrieve the token from the macOS Keychain
      token = `security find-generic-password -s "uatec-homebrew-tools-github-token" -w 2>/dev/null`.strip
      if token.empty?
        raise CurlDownloadStrategyError, "No GitHub API token found in Keychain. Run `bin/setup-keys` to set it up."
      end
      token
    end
  end
end
