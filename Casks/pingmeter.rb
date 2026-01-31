require_relative "../lib/private_strategy"

cask "pingmeter" do
  version "0.0.6"
  sha256 "75f632116f103ff614eb66f434a7d9f748c65f4d48cf307e50a3c10d7e874211"

  url "https://github.com/uatec/pingmeter/releases/download/v#{version}/PingMeter.zip",
      using: PrivateGitHubDownloadStrategy
  name "PingMeter"

  homepage "https://github.com/uatec/pingmeter"

  app "PingMeter.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/PingMeter.app"],
                   sudo: true
  end

  zap trash: [
    "~/Library/Application Support/PingMeter",
    "~/Library/Preferences/io.uatec.pingmeter.plist",
  ]
end
