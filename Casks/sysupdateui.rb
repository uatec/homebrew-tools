require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.6"
  sha256 "aadb07f73198c3a9b02e69206cd0a186e4d0bedb738d50c7002059e99c32d29d"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.6/SysUpdateUI.zip",
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
