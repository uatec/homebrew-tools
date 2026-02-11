require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.76/Baird-linux-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.76"
  sha256 "47214b368b449c549c98d16fe028777de7c31cc4068849d4d1188401b78cb177"


    # depends_on "libgbm1"
    # depends_on "libdrm2"
    # depends_on "libinput10"
    # depends_on "libglapi-mesa"
    # depends_on "libgl1-mesa-dri"
    # depends_on "libegl-mesa0"
    # depends_on "libegl1"
    # depends_on "libicu-dev"
    # depends_on "libmpv-dev"

  # If this is for Linux specifically
  depends_on :linux

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"Baird" => "baird"
  end
end
