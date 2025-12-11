local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

--local opts = {}
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = false,
	update_in_insert = false,
})




vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/venv/bin/python")


--nnoremap("<C-d>", "<C-d>zz")
--nnoremap("<C-u>", "<C-u>zz")

--nnoremap("n", "nzzzv")
--nnoremap("N", "Nzzzv")
