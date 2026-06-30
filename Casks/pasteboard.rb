cask "pasteboard" do
  version "1.0.0"
  sha256 "31d2c0a753a3a7bcdd6069f94926fe8a21d38f611a3093e4ed76d692bc23dcef"

  url "https://github.com/yusufgltc/PasteBoard/releases/download/v#{version}/PasteBoard-#{version}.zip"
  name "PasteBoard"
  desc "Clipboard history manager for older Macs"
  homepage "https://github.com/yusufgltc/PasteBoard"

  app "PasteBoard.app"

  postflight do
    puts ""
    puts "  ╭─────────────────────────────────────────────────────────╮"
    puts "  │           PasteBoard — Clipboard Permission             │"
    puts "  ╰─────────────────────────────────────────────────────────╯"
    puts ""
    puts "  PasteBoard records everything you copy so you can"
    puts "  retrieve it later. All data stays on your Mac —"
    puts "  nothing is sent to any server."
    puts ""

    if $stdin.isatty
      print "  Enable clipboard monitoring? [y/N]: "
      $stdout.flush
      answer = ($stdin.gets || "").chomp.downcase
    else
      answer = "n"
    end

    puts ""

    if answer == "y"
      system_command "/usr/bin/defaults",
        args: ["write", "com.pasteboard.app", "pasteboardMonitoringEnabled", "-bool", "true"]
      puts "  ✓ Monitoring enabled. Press ⌘⇧V to open your history."
    else
      puts "  Monitoring is off. Press ⌘⇧V → Settings to enable it later."
    end

    # Mark first-launch as seen — the choice was made here in the terminal,
    # so the app does not need to open Settings on first launch.
    system_command "/usr/bin/defaults",
      args: ["write", "com.pasteboard.app", "pasteboardHasLaunchedBefore", "-bool", "true"]

    puts ""
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
