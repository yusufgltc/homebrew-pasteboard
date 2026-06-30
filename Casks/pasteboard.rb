cask "pasteboard" do
  version "1.0.0"
  sha256 "516542205f6ee133969b667fafe1ea669745cb61675a524592e2b0d5495eec27"

  url "https://github.com/yusufgltc/PasteBoard/releases/download/v#{version}/PasteBoard-#{version}.zip"
  name "PasteBoard"
  desc "Clipboard history manager for older Macs"
  homepage "https://github.com/yusufgltc/PasteBoard"

  app "PasteBoard.app"

  postflight do
    system_command "/usr/bin/open", args: ["-a", "PasteBoard"]
  end

  uninstall quit:   "com.pasteboard.app",
            delete: "~/Library/Preferences/com.pasteboard.app.plist"

  caveats do
    <<~EOS
      ╭──────────────────────────────────────────────────────────────╮
      │                                                              │
      │    ┌──────────────┐                                          │
      │    │  ┌────────┐  │    PasteBoard #{version}                │
      │    │  │        │  │                                          │
      │    │  └────────┘  │    Clipboard history for Macs           │
      │    │              │    that can't run macOS Tahoe.           │
      │    │  ──────────  │                                          │
      │    │  ──────────  │    ⌘⇧V  ·  Open clipboard history       │
      │    │  ──────────  │    Tab  ·  Select an item               │
      │    │              │    ↵    ·  Paste                        │
      │    └──────────────┘                                          │
      │                        Open Settings to enable               │
      │                        clipboard monitoring.                 │
      │                                                              │
      ╰──────────────────────────────────────────────────────────────╯
    EOS
  end

  zap trash: [
    "~/Library/Application Support/PasteBoard",
    "~/Library/Preferences/com.pasteboard.app.plist",
    "~/Library/Saved Application State/com.pasteboard.app.savedState",
  ]
end
