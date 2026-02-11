require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.80/Baird-linux-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.80"
  sha256 "a5e2d6b7b708fa433fe2383a22e70a45f4fb8db74a1732416f2619efb71fc78d"


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
