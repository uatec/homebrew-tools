require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Sysupdate < Formula
  desc "Tool for managing many different software update mechanisms with a unified interface"
  homepage "https://github.com/uatec/sysupdate"
  url "https://github.com/uatec/sysupdate/releases/download/v0.0.22/sysupdate-osx-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.22"
  sha256 "79072bf8769f0f90ad74629b5061a56ee46f72254bf9083df57508b40134cfe6"

  def install
    bin.install "sysupdate"
  end

  test do
    system "#{bin}/sysupdate", "--version"
  end
end
