require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Sysupdate < Formula
  desc "Tool for managing many different software update mechanisms with a unified interface"
  homepage "https://github.com/uatec/sysupdate"
  url "https://github.com/uatec/sysupdate/releases/download/v0.0.11/sysupdate-osx-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.11"
  sha256 "dd444962b5cfc8726fcca91295330eeefcd271ccf4d3212dde4ee1bae40e78ce"

  def install
    bin.install "sysupdate"
  end

  test do
    system "#{bin}/sysupdate", "--version"
  end
end
