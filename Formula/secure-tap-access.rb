class SecureTapAccess < Formula
  desc "Helper to setup authenticated access for uatec/tools tap"
  homepage "https://github.com/uatec/homebrew-tools"
  url "https://raw.githubusercontent.com/uatec/homebrew-tools/main/bin/secure-tap-access"
  version "0.1.1"
  sha256 "0d91151fb3706848e9bce24550c0d6b600dcd6089a1fa6488b98ede8ff905b57"

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
