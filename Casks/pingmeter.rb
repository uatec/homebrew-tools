require (Tap.fetch("uatec/tools").path/"lib/private_strategy").to_s

cask "pingmeter" do
  version "0.0.7"
  sha256 "276ec6744d798f6b441c255049a0da73bbdbae6c02918f19bf19f1eccdea7e7b"

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
