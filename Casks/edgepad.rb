cask "edgepad" do
  version "2.1.3"
  sha256 "3e603d9cb30c0ed4adb3a33d028b278bde45f02dba9019ad3cf2d33818589ede"

  url "https://github.com/X377AAHIL/EdgePad/releases/download/v#{version}/EdgePad-#{version}.zip"
  name "EdgePad"
  desc "Turn your trackpad edges into powerful system controls"
  homepage "https://github.com/X377AAHIL/EdgePad"

  app "EdgePad.app"

  uninstall quit:        "com.aahilshaaravg.EdgePad",
            login_item:  "EdgePad",
            script:      [
              {
                executable: "/usr/bin/tccutil",
                args:       ["reset", "Accessibility", "com.aahilshaaravg.EdgePad"],
                sudo:       false,
              },
              {
                executable: "/usr/bin/tccutil",
                args:       ["reset", "ListenEvent", "com.aahilshaaravg.EdgePad"],
                sudo:       false,
              },
            ]

  zap trash: [
    "~/Library/Preferences/com.aahilshaaravg.EdgePad.plist",
    "~/Library/Application Support/EdgePad",
  ]
end
