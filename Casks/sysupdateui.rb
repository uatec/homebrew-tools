require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.4"
  sha256 "9f3dedfe25947f96c59a9d229df8ed72b2ab8b46fb6d7e04ad5d77645def14f6"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.4/SysUpdateUI.zip",
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
