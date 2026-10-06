cask "edgepad" do
  version "1.1.0"
  sha256 "2a6b8cb11ac2fc5ba6f6b31a4acd1014fb21e23b9b2dcc872409c8f7dc9562a1"

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
