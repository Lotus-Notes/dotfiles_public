return {
  "Vigemus/iron.nvim",
  ft = { "python" },
  config = function()
    local iron = require("iron.core")

    -- helper to find the newest kernel-*.json
    local function latest_kernel()
      local runtime = vim.fn.systemlist("jupyter --runtime-dir")[1]
      if runtime == nil or runtime == "" then return nil end
      local glob = vim.fn.glob(runtime .. "/kernel-*.json", false, true)
      if #glob == 0 then return nil end
      table.sort(glob, function(a, b) return vim.fn.getftime(a) > vim.fn.getftime(b) end)
      return glob[1]
    end

    iron.setup({
      config = {
        scratch_repl = true,
        repl_open_cmd = "botright 15split",
        repl_definition = {
          python = {
            -- dynamic command: attach to running notebook kernel if found
            command = function()
              local k = latest_kernel()
              if k then
                return { "jupyter", "console", "--existing", k }
              else
                return { "ipython", "--no-autoindent" }
              end
            end,
          },
        },
        preferred = { python = "python" },
      },
      keymaps = {
        send_line   = "<leader>sl",
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file   = "<leader>sf",
        interrupt   = "<leader>si",
        exit        = "<leader>sq",
        clear       = "<leader>cl",
      },
    })

    -- QoL: force-attach to the newest Jupyter kernel (if you know one is running)
    vim.keymap.set("n", "<leader>sJ", function()
      local k = latest_kernel()
      if k then
        vim.cmd("botright 15split | terminal jupyter console --existing " .. vim.fn.fnameescape(k))
      else
        vim.notify("No running Jupyter kernels found (start Notebook/Lab first).", vim.log.levels.WARN)
      end
    end, { desc = "Open Jupyter console attached to latest kernel" })

    -- convenience
    vim.keymap.set("n", "<leader>sr", ":IronRepl<CR>",  { desc = "Start REPL" })
    vim.keymap.set("n", "<leader>ss", ":IronFocus<CR>", { desc = "Focus REPL" })
    vim.keymap.set("n", "<leader>sh", ":IronHide<CR>",  { desc = "Hide REPL" })
  end,
}

