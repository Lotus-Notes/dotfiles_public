-- Choose which parts of the screenshot port to enable. Every option defaults to
-- true, which is exactly how Omarchy behaves. Install copies this file only if
-- it's missing, so your choices survive redeploys.
return {
  screenshot = true, -- Print: freeze, pick (with keyboard control), save + copy + notify
  color_picker = true, -- Super+Print: hyprpicker, hex color to the clipboard
  ocr = true, -- Super+Ctrl+Print: text from a region to the clipboard
  edit_last = true, -- Super+Alt+,: open the last screenshot in Tensaku
}
