return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				term_colors = true,
				--	LineNr = { fg = "#ffffff" },
				--	CursorLineNr = { fg = "#ffffff", style = { "bold" } },
			})

			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
