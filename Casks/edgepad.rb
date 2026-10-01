cask "edgepad" do
  version "1.0.1"
  sha256 "824d4fe9533d6f0d2375141660c80fd6a021b38613802f7a12ae41b5083bc71b"

  url "https://github.com/X377AAHIL/EdgePad/releases/download/v#{version}/EdgePad-#{version}.dmg"
  name "EdgePad"
  desc "Turn your trackpad edges into powerful system controls"
  homepage "https://github.com/X377AAHIL/EdgePad"

  app "EdgePad.app"

  # The app is not notarized, so we must strip the quarantine
  # attribute to prevent macOS Gatekeeper from blocking it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/EdgePad.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/EdgePad.app"]
  end

  uninstall_postflight do
    system_command "/usr/bin/tccutil",
                   args: ["reset", "Accessibility", "com.aahilshaaravg.EdgePad"]
    system_command "/usr/bin/tccutil",
                   args: ["reset", "ListenEvent", "com.aahilshaaravg.EdgePad"]
  end

  uninstall quit:       "com.aahilshaaravg.EdgePad",
            login_item: "EdgePad"

  zap trash: [
    "~/Library/Preferences/com.aahilshaaravg.EdgePad.plist",
    "~/Library/Application Support/EdgePad",
  ]
end
