-- Choose which parts of the clipboard port to enable. Every option defaults to
-- true, which is exactly how Omarchy behaves. Install copies this file only if
-- it's missing, so your choices survive redeploys.
return {
  universal_clipboard = true, -- Super+C / Super+V / Super+X (terminal-aware copy/paste/cut)
  clipboard_history = true, -- Super+Ctrl+V history overlay, plus its background watcher
}
