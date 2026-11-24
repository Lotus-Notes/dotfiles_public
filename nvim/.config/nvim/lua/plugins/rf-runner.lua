return {
  {
    name = "rf-runner",
    dir = vim.fn.stdpath("config"),
    config = function()
      require("rf.runner").setup({
        key = "<leader>r",
        keep_focus = false,
        python_cmd = "ipython",
        interactive = true,
      })
    end,
  },
}
