return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula",
        component_separators = "",
        section_separators = {
          left = "",
          right = "",
        },
        globalstatus = true,
      },

      sections = {
        lualine_a = {
          "mode",
        },

        lualine_b = {},

        lualine_c = {
          {
            function()
              local ok, devicons = pcall(require, "nvim-web-devicons")
              if not ok then
                return ""
              end

              local filename = vim.fn.expand("%:t")
              local extension = vim.fn.expand("%:e")
              local icon = devicons.get_icon(filename, extension, { default = true })

              return icon
            end,

            color = function()
              local ok, devicons = pcall(require, "nvim-web-devicons")
              if not ok then
                return {}
              end

              local filename = vim.fn.expand("%:t")
              local extension = vim.fn.expand("%:e")
              local _, icon_color = devicons.get_icon_color(filename, extension, { default = true })

              return { fg = icon_color }
            end,
          },

          {
            "filename",
            path = 1,
            file_status = true,
            newfile_status = false,
            symbols = {
              modified = " [+]",
              readonly = " ",
            },
          },

          {
            "diagnostics",

            sources = { "nvim_diagnostic" },

            sections = { "error", "warn" },

            diagnostics_color = {
              error = { fg = "#f38ba8" },
              warn = { fg = "#f9e2af" },
            },

            symbols = {
              error = " ",
              warn = " ",
            },

            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },

        lualine_x = {

          {
            function()
              local os = vim.loop.os_uname().sysname

              if os == "Linux" then
                return ""
              elseif os == "Windows_NT" then
                return "󰍲"
              elseif os == "Darwin" then
                return ""
              else
                return ""
              end
            end,
          },
        },

        lualine_y = {
          "progress",
          "location",
        },

        lualine_z = {
          {
            function()
              return "󰥔 " .. os.date("%H:%M")
            end,
          },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          "filename",
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
