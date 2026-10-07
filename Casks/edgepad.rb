cask "edgepad" do
  version "1.1.0"
  sha256 "0875fd93739e5e90fd6d87c017a3b040ff28560ee849183a4112af76fe8123b7"

  url "https://github.com/X377AAHIL/EdgePad/releases/download/v#{version}/EdgePad-#{version}.zip"
  name "EdgePad"
  desc "Turn your trackpad edges into powerful system controls"
  homepage "https://github.com/X377AAHIL/EdgePad"

  app "EdgePad.app"

  postflight_steps do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "{{appdir}}/EdgePad.app"], must_succeed: false
  end

  uninstall_postflight_steps do
    system_command "/usr/bin/tccutil",
                   args: ["reset", "Accessibility", "com.aahilshaaravg.EdgePad"], must_succeed: false
    system_command "/usr/bin/tccutil",
                   args: ["reset", "ListenEvent", "com.aahilshaaravg.EdgePad"], must_succeed: false
  end

  uninstall quit:        "com.aahilshaaravg.EdgePad",
            login_item:  "EdgePad"

  zap trash: [
    "~/Library/Preferences/com.aahilshaaravg.EdgePad.plist",
    "~/Library/Application Support/EdgePad",
  ]
end
