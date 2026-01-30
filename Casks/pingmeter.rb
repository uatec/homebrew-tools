require_relative "../lib/private_strategy"

cask "pingmeter" do
  version "0.0.3"
  sha256 "03082dcd5acf518c5d19ff7d4e59ea46fafdde9ba5316cfc802b8fcbe705a873"

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
