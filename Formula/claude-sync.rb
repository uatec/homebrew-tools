require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class ClaudeSync < Formula
  desc "Sync Claude Code and Claude Desktop config across machines"
  homepage "https://github.com/uatec/claude-sync"
  url "https://github.com/uatec/claude-sync/archive/refs/tags/v0.2.0.tar.gz",
      using: PrivateGitHubDownloadStrategy
  version "0.2.0"
  sha256 "b78ff42a331fbffd6f05aae643957664e4239931c4e9c24636481b810b212a2a"
  license "MIT"

  depends_on "git"
  depends_on "jq"
  depends_on "rsync"

  def install
    libexec.install "lib"
    libexec.install "bin" => "libexec-bin"
    (bin/"claude-sync").write <<~EOS
      #!/usr/bin/env bash
      export CLAUDE_SYNC_LIB="#{libexec}/lib"
      exec "#{libexec}/libexec-bin/claude-sync" "$@"
    EOS
    chmod 0755, bin/"claude-sync"
  end

  def caveats
    <<~EOS
      Next steps:
        1. claude-sync init git@github.com:<you>/claude-config.git
        2. claude-sync install-timer

      Ensure your SSH agent is available to the scheduled job
      (systemd user session on Linux, Keychain integration on macOS).
    EOS
  end

  test do
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/claude-sync --version"))
  end
end
