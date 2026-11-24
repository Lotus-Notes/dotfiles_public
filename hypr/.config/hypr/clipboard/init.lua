-- Omarchy's universal clipboard + clipboard history for plain Hyprland.
-- Installed to ~/.config/hypr/clipboard/; load it from hyprland.lua with:
--   dofile(os.getenv("HOME") .. "/.config/hypr/clipboard/init.lua")
-- Load it after your own bindings so SUPER+C / SUPER+V win over any
-- earlier binds on those keys.

local dir = os.getenv("HOME") .. "/.config/hypr/clipboard"

-- Everything on by default (exactly Omarchy). features.lua can turn parts off;
-- a missing file keeps the defaults, a broken one is reported by configerrors.
local features = { universal_clipboard = true, clipboard_history = true }
local ok, user = pcall(dofile, dir .. "/features.lua")
if ok and type(user) == "table" then
  for name, enabled in pairs(user) do
    features[name] = enabled
  end
elseif not ok and not tostring(user):find("No such file") then
  error(user)
end

-- Hyprland's stock config binds SUPER+C (close window) and SUPER+V (toggle
-- floating). Unbind a key before rebinding it, as Omarchy's own overrides do.
-- Rebind what you lose elsewhere in your own config.
if features.universal_clipboard then
  hl.unbind("SUPER + C")
  hl.unbind("SUPER + V")
  hl.unbind("SUPER + X")
  dofile(dir .. "/apps/terminals.lua")
end

if features.clipboard_history then
  hl.unbind("SUPER + CTRL + V")
  dofile(dir .. "/apps/clipboard-history.lua")
end

clipboard_features = features
dofile(dir .. "/bindings/clipboard.lua")

-- Omarchy starts its whole shell (which owns the clipboard watcher and
-- overlay) from autostart.lua via omarchy-launch-shell.
if features.clipboard_history then
  hl.on("hyprland.start", function()
    hl.exec_cmd(os.getenv("HOME") .. "/.local/bin/clipboard-launch")
  end)
end
