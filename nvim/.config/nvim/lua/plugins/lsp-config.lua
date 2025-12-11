return {
	{

		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			--ensure_install = {"lua_ls", "pylsp"},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Define configs with the new API
			vim.lsp.config["lua_ls"] = {
				capabilities = capabilities,
				-- settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			}

			vim.lsp.config["pylsp"] = {
				capabilities = capabilities,
			}

			vim.lsp.config["matlab_ls"] = {
				capabilities = capabilities,
			}
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
