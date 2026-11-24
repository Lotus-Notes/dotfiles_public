-- Omarchy's screenshot / PrtSc tools for plain Hyprland.
-- Installed to ~/.config/hypr/screenshot/; load it from hyprland.lua with:
--   dofile(os.getenv("HOME") .. "/.config/hypr/screenshot/init.lua")
-- Load it after your own bindings so these keys win over any earlier binds.

local dir = os.getenv("HOME") .. "/.config/hypr/screenshot"

-- Everything on by default (exactly Omarchy). features.lua can turn parts off;
-- a missing file keeps the defaults, a broken one is reported by configerrors.
local features = { screenshot = true, color_picker = true, ocr = true, edit_last = true }
local ok, user = pcall(dofile, dir .. "/features.lua")
if ok and type(user) == "table" then
  for name, enabled in pairs(user) do
    features[name] = enabled
  end
elseif not ok and not tostring(user):find("No such file") then
  error(user)
end

-- Unbind a key before rebinding it, as Omarchy's own overrides do, so an
-- existing screenshot tool on these keys doesn't fire as well. A feature
-- that's off leaves its key as the user's own config binds it.
if features.screenshot then
  hl.unbind("PRINT")
end
-- Screenshot and OCR both pick with slurp, whose layer this rule styles.
if features.screenshot or features.ocr then
  dofile(dir .. "/apps/screenshot-selection.lua")
end
if features.color_picker then
  hl.unbind("SUPER + PRINT")
end
if features.ocr then
  hl.unbind("SUPER + CTRL + PRINT")
end
if features.edit_last then
  hl.unbind("SUPER + ALT + comma")
end
if features.screenshot or features.edit_last then
  dofile(dir .. "/apps/tensaku.lua")
end

screenshot_features = features
dofile(dir .. "/bindings/screenshot.lua")
