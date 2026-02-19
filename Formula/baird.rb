require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class Baird < Formula
  desc "Fully integrated tv and streaming media player"
  homepage "https://github.com/uatec/baird"
  url "https://github.com/uatec/baird/releases/download/v0.0.163/Baird-linux-arm64.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.163"
  sha256 "b1f8d0b96aba2bc85f23f27fa8a2fb851cecdd1e44df5ba78e275ac308bd8e0f"


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
    # 1. Compress the binary so Homebrew's scanner ignores it.
    #    This bypasses the crash entirely.
    system "gzip", "Baird"
    
    # 2. Install the compressed file and the libraries
    libexec.install Dir["*"]

    # 3. Create a wrapper script to run it.
    #    On first run, it unzips the binary to a cache folder.
    (bin/"baird").write <<~EOS
      #!/bin/bash
      set -e

      # We run the binary from the user's cache to keep the install clean
      CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/baird"
      REAL_BINARY="$CACHE_DIR/Baird"
      SOURCE_GZ="#{libexec}/Baird.gz"

      # If the binary doesn't exist or is older than the install, unzip it
      if [ ! -f "$REAL_BINARY" ] || [ "$SOURCE_GZ" -nt "$REAL_BINARY" ]; then
        mkdir -p "$CACHE_DIR"
        gunzip -c "$SOURCE_GZ" > "$REAL_BINARY"
        chmod +x "$REAL_BINARY"
      fi

      # Ensure the shared libraries are found
      export LD_LIBRARY_PATH="#{libexec}:$LD_LIBRARY_PATH"

      # Run!
      exec "$REAL_BINARY" "$@"
    EOS
  end
end
