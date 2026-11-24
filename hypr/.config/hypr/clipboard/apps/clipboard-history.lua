-- Layer rule for the clipboard history overlay. Omarchy's omarchy-shell.lua
-- groups this with its launcher/emoji/panel surfaces; only the clipboard one
-- applies here.

-- Clipboard overlays should pop without compositor layer fades.
hl.layer_rule({ match = { namespace = "^(clipboard-history)$" }, no_anim = true, animation = "none" })
