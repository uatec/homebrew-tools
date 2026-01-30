require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.3"
  sha256 "217b6d8dddb2d8623b6ebdecbb97f45541144dd6bca63a3c4fa328e39c991df9"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.3/SysUpdateUI.zip",
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
