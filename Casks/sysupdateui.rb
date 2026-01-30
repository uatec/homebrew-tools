require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.5"
  sha256 "924254232801cfb3a95c12a1b9550b7d0dfe7843bbd5c10a5e05fcb2838cae4a"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.5/SysUpdateUI.zip",
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
