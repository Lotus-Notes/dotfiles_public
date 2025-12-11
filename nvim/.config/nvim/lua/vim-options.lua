vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true

vim.g.background = "dark"
vim.g.foreground = "dark"
vim.opt.swapfile = false

vim.opt.wrap = true 
vim.opt.termguicolors = true


vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Primeagen Page up/down keybinds --
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<n>", "nzzzv")
vim.keymap.set("n", "<N>", "Nzzzv")

-- using vim.api.nvim_set_hl
vim.api.nvim_set_hl(0, "LineNr",       { fg = "#A6E3A1", bg = "none", bold = false })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F28FAD", bg = "none", bold = true  })

local function toggle_virtual_text()
  diagnostics_virtual_text = not diagnostics_virtual_text
  vim.diagnostic.config({
    virtual_text = diagnostics_virtual_text,
    signs = true,
    underline = false,
    update_in_insert = false,
  })
  vim.notify("Diagnostics virtual text: " .. (diagnostics_virtual_text and "ON" or "OFF"))
end

vim.keymap.set("n", "<leader>dv", toggle_virtual_text, { desc = "Toggle diagnostic virtual text" })
