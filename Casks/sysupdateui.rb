require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.8"
  sha256 "1b259340d5a47637a3fd659006671920ce058188971265334593d5b3b6b89cd8"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.8/SysUpdateUI.zip",
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
