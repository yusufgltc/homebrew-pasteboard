cask "pasteboard" do
  version "1.0.0"
  sha256 "1baee56c3c3a11b22d609305c08b7713f8275c979a399dc3bf805ac658f8ad17"

  url "https://github.com/yusufgltc/PasteBoard/releases/download/v#{version}/PasteBoard-#{version}.zip"
  name "PasteBoard"
  desc "Clipboard history manager for macOS"
  homepage "https://github.com/yusufgltc/PasteBoard"

  app "PasteBoard.app"

  postflight do
    system_command "/usr/bin/open", args: ["-a", "PasteBoard"]
  end

  zap trash: [
    "~/Library/Application Support/PasteBoard",
    "~/Library/Preferences/com.pasteboard.app.plist",
    "~/Library/Saved Application State/com.pasteboard.app.savedState",
  ]
end
