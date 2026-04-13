class ClaudeSync < Formula
  desc "Sync Claude Code and Claude Desktop config across machines"
  homepage "https://github.com/uatec/claude-sync"
  url "https://github.com/uatec/claude-sync/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  version "0.1.0"

  depends_on "git"
  depends_on "jq"
  depends_on "rsync"

  def install
    libexec.install "lib"
    libexec.install "bin" => "libexec-bin"
    (bin/"claude-sync").write <<~SCRIPT
      #!/usr/bin/env bash
      export CLAUDE_SYNC_LIB="#{libexec}/lib"
      exec "#{libexec}/libexec-bin/claude-sync" "$@"
    SCRIPT
    chmod 0755, bin/"claude-sync"
  end

  def caveats
    <<~EOS
      Next steps:
        1. claude-sync init git@github.com:<you>/claude-config.git
        2. claude-sync install-timer

      Ensure your SSH agent is available to the scheduled job
      (systemd user session or macOS Keychain integration).
    EOS
  end

  test do
    assert_match(/\d+\.\d+\.\d+/, shell_output("#{bin}/claude-sync --version"))
  end
end
