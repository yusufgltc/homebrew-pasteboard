cask "pasteboard" do
  version "1.0.0"
  sha256 "7aaea61c2de703872453b010c23a7620bc01548d62d5f50de53f367320801b19"

  url "https://github.com/yusufgltc/PasteBoard/releases/download/v#{version}/PasteBoard-#{version}.zip"
  name "PasteBoard"
  desc "Clipboard history manager for macOS"
  homepage "https://github.com/yusufgltc/PasteBoard"

  app "PasteBoard.app"

  zap trash: [
    "~/Library/Application Support/PasteBoard",
    "~/Library/Preferences/com.pasteboard.app.plist",
    "~/Library/Saved Application State/com.pasteboard.app.savedState",
  ]
end
