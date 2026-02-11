require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.79/Baird-linux-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.79"
  sha256 "075026b81203c2b5674c6303c2eaf40efc7be485ff57bfd292d4480baaa907c4"


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
