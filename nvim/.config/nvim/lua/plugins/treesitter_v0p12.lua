return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/treesitter",
      })

      vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/treesitter")

      local parsers = {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
      }

      ts.install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local filetype = args.match
          local lang = vim.treesitter.language.get_lang(filetype) or filetype

          if vim.tbl_contains(parsers, lang) then
            pcall(vim.treesitter.start)
          end
        end,
      })
    end,
  },
}
