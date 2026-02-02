require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

cask "sysupdateui" do
  version "0.0.11"
  sha256 "168637d0540776ca3cba51bc81adc41b0fc8ec308759b8396b4bf6e76315e3db"

  url "https://github.com/uatec/sysupdateui/releases/download/v0.0.11/SysUpdateUI.zip",
      using: PrivateGitHubDownloadStrategy
  name "SysUpdateUI"

  homepage "https://github.com/uatec/sysupdateui"
  app "SysUpdateUI.app"

  uninstall_preflight do
    if system "/usr/bin/pgrep", "-q", "-x", "SysUpdateUI"
      File.write("/tmp/sysupdateui_restart_required", "")
      system "/usr/bin/pkill", "-x", "SysUpdateUI"
      10.times do
        break unless system "/usr/bin/pgrep", "-q", "-x", "SysUpdateUI"
        sleep 0.5
      end
    end
  end

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/SysUpdateUI.app"],
                   sudo: true

    if File.exist?("/tmp/sysupdateui_restart_required")
      system "/usr/bin/open", "#{appdir}/SysUpdateUI.app"
      FileUtils.rm_f "/tmp/sysupdateui_restart_required"
    end
  end

  zap trash: [
    "~/Library/Application Support/SysUpdateUI",
    "~/Library/Preferences/io.uatec.sysupdateui.plist",
  ]
end
