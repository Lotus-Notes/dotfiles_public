return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup Python debug adapter
			local python_path = vim.fn.exepath("python3")
			require("dap-python").setup(python_path)
			require("dap-python").test_runner = "pytest"

			-- Single launch config for current file
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch Current File",
					program = "${file}",
					pythonPath = function()
						return python_path
					end,
				},
			}

			-- DAP UI setup
			dapui.setup()
			-- Auto open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			-- Keymaps for debugging
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},

	{
		-- Compiler plugin with Overseer.nvim dependency included
		"zeioth/compiler.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/overseer.nvim",
		},
		config = function()
			-- Setup compiler.nvim (will auto-use Overseer)
			require("compiler").setup({})

			-- Keymaps for compiling and managing output
			vim.keymap.set("n", "<leader>cc", ":CompilerOpen<CR>", { desc = "Compile current file" })
			vim.keymap.set("n", "<leader>co", ":CompilerOutputOpen<CR>", { desc = "Open compiler output" })
			vim.keymap.set("n", "<leader>cq", ":CompilerOutputClose<CR>", { desc = "Close compiler output" })
		end,
	},
}
