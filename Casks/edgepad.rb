cask "edgepad" do
  version "1.0.0"
  sha256 "2e3695246576bfc9e0996e48a406c972998b6e2ac9f7debfe6f85e279db43719"

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
