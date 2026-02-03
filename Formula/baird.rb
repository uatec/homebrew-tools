require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.1/Baird-linux-arm64.zip"
    using: PrivateGitHubDownloadStrategy
  version "v0.0.1"
  sha256 "9aba31be07a4f699b8af19efb09267c86580a7a382ede69402490676b9b09461"

  # If this is for Linux specifically
  depends_on :linux

  def install
    bin.install "Baird" => "baird"
  end
end
