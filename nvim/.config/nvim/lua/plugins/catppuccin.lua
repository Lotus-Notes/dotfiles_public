return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,

    opts = {
      flavour = "mocha",
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          LineNr       = { fg = colors.overlay0 },
          CursorLineNr = { fg = colors.peach, style = {"bold"} },
          --RelLineNr  = { fg = colors.lavender },
        }
      end,
    },

		config = function(_,opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
