require_relative "../lib/private_strategy"

class Sysupdate < Formula
  desc "Tool for managing many different software update mechanisms with a unified interface"
  homepage "https://github.com/uatec/sysupdate"
  url "https://github.com/uatec/sysupdate/releases/download/v0.0.9/sysupdate-osx-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.9"
  sha256 "9586493c27f6119940b119a142250fd7625bc904ba80403f6a90618d7d130311"

  def install
    bin.install "sysupdate"
  end

  test do
    system "#{bin}/sysupdate", "--version"
  end
end
