require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.1"
  sha256 "ae2678956fb922306c70bc2cf76435089cae41125adb20928db8d6d4a8873481"

  url "https://github.com/uatec/updatetracker/releases/download/v0.0.1/SysUpdateUI.zip",
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
