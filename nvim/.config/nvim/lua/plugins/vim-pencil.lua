return {
  "preservim/vim-pencil",
  ft = { "markdown", "text" },

  config = function()
    vim.g["pencil#wrapModeDefault"] = "soft"
  end,
}
