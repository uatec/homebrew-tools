require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Sysupdate < Formula
  desc "Tool for managing many different software update mechanisms with a unified interface"
  homepage "https://github.com/uatec/sysupdate"
  url "https://github.com/uatec/sysupdate/releases/download/v0.0.12/sysupdate-osx-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.12"
  sha256 "fbf5677454119ab2dde523f84cef9e06a3cb6cd85b7be62a4830a3edf683358e"

  def install
    bin.install "sysupdate"
  end

  test do
    system "#{bin}/sysupdate", "--version"
  end
end
