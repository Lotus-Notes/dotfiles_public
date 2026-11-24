-- Tensaku (screenshot annotator) window rules from Omarchy's
-- default/hypr/apps/system.lua; the rest of that file covers Omarchy's own apps.
-- Omarchy's o.window(class, rules) wraps hl.window_rule.
hl.window_rule({ match = { class = "dev.tensaku.Tensaku" }, float = true })
hl.window_rule({ match = { class = "dev.tensaku.Tensaku" }, center = true })
