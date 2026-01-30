require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.2"
  sha256 "409e2ab33f9a71c1303f54001295a3481526d05c4313c55c4dd758d4c21aae83"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.2/SysUpdateUI.zip",
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
