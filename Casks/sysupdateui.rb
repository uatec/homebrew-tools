require_relative "../lib/private_strategy"

cask "sysupdateui" do
  version "0.0.0"
  sha256 "8699bc45a7ea7508762799bbd91b8a38e1d224f4763023fc293600c5752e17f7"

  url "xxx",
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
