return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		workspaces = {
			{
				name = "Lotus",
				path = "~/Dropbox/Lotus_Notes/Lotus/",
			},
		},

    disable_frontmatter = true,

    templates = {
      folder = "3_Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
	},

  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            vim.opt_local.conceallevel = 2
        end,
    })
  end,

  keys = {
    { "<C-T>", "<cmd>ObsidianTemplate<cr>", desc = "Insert Obsidian Template" },
  },
}
