cask "edgepad" do
  version "1.0.4"
  sha256 "dbaa20c123ffe6e513389a3b5343d66a7558435cc027a321c60c9f4f29793b53"

  url "https://github.com/X377AAHIL/EdgePad/releases/download/v#{version}/EdgePad-#{version}.dmg"
  name "EdgePad"
  desc "Turn your trackpad edges into powerful system controls"
  homepage "https://github.com/X377AAHIL/EdgePad"

  app "EdgePad.app"

  # The app is not notarized, so we must strip the quarantine
  # attribute to prevent macOS Gatekeeper from blocking it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/EdgePad.app"], must_succeed: false
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/EdgePad.app"], must_succeed: false
  end

  uninstall_postflight do
    system_command "/usr/bin/tccutil",
                   args: ["reset", "Accessibility", "com.aahilshaaravg.EdgePad"], must_succeed: false
    system_command "/usr/bin/tccutil",
                   args: ["reset", "ListenEvent", "com.aahilshaaravg.EdgePad"], must_succeed: false
  end

  uninstall quit:       "com.aahilshaaravg.EdgePad",
            login_item: "EdgePad"

  zap trash: [
    "~/Library/Preferences/com.aahilshaaravg.EdgePad.plist",
    "~/Library/Application Support/EdgePad",
  ]
end
