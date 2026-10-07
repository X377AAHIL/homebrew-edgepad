cask "edgepad" do
  version "2.1.2"
  sha256 "075a168b2d406724689663054d25ffd8b86b5c9098389a156740334d7a0a63d3"

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
