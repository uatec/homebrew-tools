require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.7"
  sha256 "6f316ac92c8c1a2083a15c2c7b6c6be985644964cc54f86c052ed1dc0033c0ae"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.7/SysUpdateUI.zip",
      using: PrivateGitHubDownloadStrategy
  name "SysUpdateUI"

  homepage "https://github.com/uatec/sysupdateui"
  app "SysUpdateUI.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/SysUpdateUI.app"],
                   sudo: true
  end

  zap trash: [
    "~/Library/Application Support/SysUpdateUI",
    "~/Library/Preferences/io.uatec.sysupdateui.plist",
  ]
end
