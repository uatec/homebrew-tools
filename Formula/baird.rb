require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.98/Baird-linux-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.98"
  sha256 "543ee20f60879fe9276949273bd9f13f557f502e6a31aee7e87f91c7cb945bfe"


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

  # AOT compilation produces files that are not relocatable, so we skip cleaning them.
  skip_clean :all

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"Baird" => "baird"
  end
end
