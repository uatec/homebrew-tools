require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.37/Baird-linux-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.37"
  sha256 "f5b34262f30c95f784f54ce31b79a21d4bb1d1afe859193408df05c2017bf643"


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
