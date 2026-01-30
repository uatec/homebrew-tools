require_relative "../lib/private_strategy"

cask "pingmeter" do
  version "0.0.5"
  sha256 "8699bc45a7ea7508762799bbd91b8a38e1d224f4763023fc293600c5752e17f7"

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
