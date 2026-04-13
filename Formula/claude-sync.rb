require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

class ClaudeSync < Formula
  desc "Sync Claude Code and Claude Desktop config across machines"
  homepage "https://github.com/uatec/claude-sync"
  url "https://github.com/uatec/claude-sync/releases/download/v0.0.1/claude-sync.zip",
      using: PrivateGitHubDownloadStrategy
  version "0.0.1"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
