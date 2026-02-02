require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

cask "mission-centre" do
  version "0.0.0"
  sha256 "PLACEHOLDER_SHA256"

  url "PLACEHOLDER_URL",
      using: PrivateGitHubDownloadStrategy
  name "MissionCentre"

  desc "System monitoring application inspired by Task Manager"
  homepage "https://github.com/uatec/missioncentre"
  app "MissionCentre.app"

  uninstall_preflight do
    if system "/usr/bin/pgrep", "-q", "-x", "MissionCentre"
      File.write("/tmp/missioncentre_restart_required", "")
      system "/usr/bin/pkill", "-x", "MissionCentre"
      10.times do
        break unless system "/usr/bin/pgrep", "-q", "-x", "MissionCentre"
        sleep 0.5
      end
    end
  end

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/MissionCentre.app"],
                   sudo: true

    if File.exist?("/tmp/missioncentre_restart_required")
      system "/usr/bin/open", "#{appdir}/MissionCentre.app"
      FileUtils.rm_f "/tmp/missioncentre_restart_required"
    end
  end

  zap trash: [
    "~/Library/Application Support/MissionCentre",
    "~/Library/Preferences/io.uatec.missioncentre.plist",
  ]
end
