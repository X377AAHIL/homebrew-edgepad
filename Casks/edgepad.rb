cask "edgepad" do
  version "2.0.0"
  sha256 "e7aec5918ae259bf5494099c6ae4973a022d7044e65791293d8aa8f62136587d"

  url "https://github.com/X377AAHIL/EdgePad/releases/download/v#{version}/EdgePad-#{version}.zip"
  name "EdgePad"
  desc "Turn your trackpad edges into powerful system controls"
  homepage "https://github.com/X377AAHIL/EdgePad"

  app "EdgePad.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/EdgePad.app"], must_succeed: false
  end

  uninstall quit:       "com.aahilshaaravg.EdgePad",
            login_item: "EdgePad"

  zap trash: [
    "~/Library/Preferences/com.aahilshaaravg.EdgePad.plist",
    "~/Library/Application Support/EdgePad",
  ]
end
