return {
 "folke/snacks.nvim",
  priority = 1000,
  enabled = true,
  lazy = false,
  opts = {
    image = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    git = { enabled = true },
    scope = { enabled = false },
    statuscolumn = { enabled = true },
    bigfile = { enabled = false },
    quickfile = { enabled = true },
    zen = { enabled = true },
    picker = { enabled = true },
    keymap = { enabled = true },
    terminal = { enabled = true },
    dashboard = { enabled = false,
      sections = {
     { section = "keys", gap = 1, padding = 1 },
     { section = "startup" },
     {
       section = "terminal",
       cmd = "chafa ~/.config/wall.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
       pane = 2,
       indent = 4,
       height = 5,
      },
    },
    }

  
  },

  keys = {
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode"},
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zen Zoom"},
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "keymaps"},
  }
}
