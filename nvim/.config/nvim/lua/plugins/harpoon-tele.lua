return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local harpoon = require("harpoon")
      local harpoon_extensions = require("harpoon.extensions")

			harpoon:setup({})
			local conf = require("telescope.config").values

			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers").new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					}):find()
			end

			vim.keymap.set("n", "<leader>e", function()	toggle_telescope(harpoon:list()) end, { desc = "Open Harpoon-Telescope" })
			vim.keymap.set("n", "<leader>l", function()	harpoon.ui:toggle_quick_menu(harpoon:list()) end) --Harpoon Menu

		  vim.keymap.set("n", "<leader>a", function() harpoon:list():add()	end) --Add current file to quick menu
			vim.keymap.set("n", "<leader>d", function() harpoon:list():remove()	end) --Add current file to quick menu

      -- Select Harppon List Item --	    
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
      vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
			--vim.keymap.set("n", "<C-5>", function() harpoon.list():prev() endr
			--vim.keymap.set("n", "<C-tab>", function() harpoon.list():next() end)

      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

		end,
	},
}
