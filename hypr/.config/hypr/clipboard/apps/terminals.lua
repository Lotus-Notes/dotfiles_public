-- Define terminal tag so themes and bindings can single terminals out. Omarchy
-- launches TUIs and its own terminal windows under dedicated app-ids
-- (org.omarchy.btop, org.omarchy.terminal, TUI.float, ...), so match those too.
-- The class is matched in full, so foot's other app-id needs spelling out.
-- Omarchy's o.window(class, rules) wraps hl.window_rule. The pattern is Omarchy's
-- plus WezTerm's actual app-id (org.wezfurlong.wezterm), which Omarchy misses, so
-- Super+C in WezTerm copies instead of sending Ctrl+C. clipboard-launch-tui still
-- opens editors as org.omarchy.<editor>.
hl.window_rule({
  match = { class = "(Alacritty|kitty|com.mitchellh.ghostty|foot|org\\.codeberg\\.dnkl\\.foot|wezterm|org\\.wezfurlong\\.wezterm|org\\.omarchy\\..*|TUI\\..*)" },
  tag = "+terminal",
})
