require_relative "../lib/private_strategy"

class Sysupdate < Formula
  desc "Tool for managing many different software update mechanisms with a unified interface"
  homepage "https://github.com/uatec/sysupdate"
  url "https://github.com/uatec/sysupdate/releases/download/v0.0.8/sysupdate-osx-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.8"
  sha256 "9e0ebac159bb77d4a766e07f1d81a95e460163eb3d1414fd2f5dcc5452d8aa29"

  def install
    bin.install "sysupdate"
  end

  test do
    system "#{bin}/sysupdate", "--version"
  end
end
