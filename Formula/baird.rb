class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.1/Baird-linux-arm64.zip"
  version "v0.0.1"
  sha256 "9aba31be07a4f699b8af19efb09267c86580a7a382ede69402490676b9b09461"

  # Homebrew equivalents for your list:
  depends_on "mesa"       # Provides gbm, glapi, dri, egl
  depends_on "libdrm"     # Provides libdrm2
  depends_on "libinput"   # Provides libinput10
  depends_on "icu4c"      # Provides libicu
  depends_on "mpv"        # Provides libmpv-dev headers and libs
  
  # If this is for Linux specifically
  depends_on :linux

  def install
    bin.install "Baird" => "baird"
  end
end
