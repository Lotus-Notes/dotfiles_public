-- Screenshot / PrtSc bindings from Omarchy's default/hypr/bindings/utilities.lua.
-- Omarchy's o.bind(keys, description, command) is a thin wrapper over hl.bind
-- that turns a command string into hl.dsp.exec_cmd. Commands use absolute
-- paths: plain Arch doesn't put ~/.local/bin on Hyprland's PATH.
local bin = os.getenv("HOME") .. "/.local/bin/"

-- Feature switches from init.lua (hypr/features.lua); all on matches Omarchy.
local features = screenshot_features or { screenshot = true, color_picker = true, ocr = true, edit_last = true }

if features.screenshot then
  hl.bind("PRINT", hl.dsp.exec_cmd(bin .. "capture-screenshot"), { description = "Screenshot" })
end
if features.color_picker then
  hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { description = "Color picker" })
end
if features.ocr then
  hl.bind("SUPER + CTRL + PRINT", hl.dsp.exec_cmd(bin .. "capture-text"), { description = "Extract text (OCR) from screenshot" })
end

-- Omarchy binds this to "invoke last notification" in its own notification
-- daemon, which the screenshot toast advertises as its edit shortcut. Here it
-- opens the last screenshot in the editor directly, whatever daemon is running.
-- xkbcommon names the comma keysym "comma"; the upper-case "COMMA" does not match.
if features.edit_last then
  hl.bind("SUPER + ALT + comma", hl.dsp.exec_cmd(bin .. "capture-edit-last"), { description = "Edit last screenshot" })
end

-- The region picker (and its keyboard control below) belongs to the screenshot
-- and OCR features; skip it when neither is on.
if not (features.screenshot or features.ocr) then
  return
end

-- Keyboard control for the slurp region picker (see capture-region).
-- The binds live exactly as long as a selection layer is on screen (slurp
-- opens one per monitor), so they cannot leak or get stuck.
-- Unbinding by key would take a same-key binding out of the user's own config
-- with it, so each handle is kept and removed individually.
local selection_layers = 0
local selection_binds = {}

hl.on("layer.opened", function(layer)
  if layer.namespace == "selection" then
    selection_layers = selection_layers + 1
    if selection_layers == 1 then
      selection_binds = {
        hl.bind("RETURN", hl.dsp.exec_cmd(bin .. "capture-region --take-window"), { description = "Capture highlighted window" }),
        hl.bind("CTRL + RETURN", hl.dsp.exec_cmd(bin .. "capture-region --take-fullscreen"), { description = "Capture entire screen" }),
        hl.bind("TAB", hl.dsp.exec_cmd(bin .. "capture-region --select-window next"), { description = "Select next window to capture" }),
        hl.bind("CTRL + TAB", hl.dsp.exec_cmd(bin .. "capture-region --select-window prev"), { description = "Select previous window to capture" }),
      }
      for _, direction in ipairs({ "left", "right", "up", "down" }) do
        table.insert(
          selection_binds,
          hl.bind(direction:upper(), hl.dsp.exec_cmd(bin .. "capture-region --select-window " .. direction), { description = "Select window to capture" })
        )
      end
    end
  end
end)

hl.on("layer.closed", function(layer)
  if layer.namespace == "selection" and selection_layers > 0 then
    selection_layers = selection_layers - 1
    if selection_layers == 0 then
      for _, keybind in ipairs(selection_binds) do
        keybind:unbind()
      end
      selection_binds = {}
    end
  end
end)
