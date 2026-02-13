require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Sysupdate < Formula
  desc "Tool for managing many different software update mechanisms with a unified interface"
  homepage "https://github.com/uatec/sysupdate"
  url "https://github.com/uatec/sysupdate/releases/download/v0.0.15/sysupdate-osx-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.15"
  sha256 "db1f1d3af313d12cbc089699f693e4c33ae595a296249c9082d5512b6192959e"

  def install
    bin.install "sysupdate"
  end

  test do
    system "#{bin}/sysupdate", "--version"
  end
end
