class SecureTapAccess < Formula
  desc "Helper to setup authenticated access for uatec/tools tap"
  homepage "https://github.com/uatec/homebrew-tools"
  url "https://raw.githubusercontent.com/uatec/homebrew-tools/main/bin/secure-tap-access"
  version "0.1.0"
  sha256 "e1fb437c7d82d35c0ff26f2711f9f22ce098281ec872c51da29ca03de826ca04"

  def install
    bin.install "secure-tap-access"
  end

  def caveats
    <<~EOS
      To set up your GitHub token for private tap access, run:
        secure-tap-access
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/secure-tap-access --help")
  end
end
