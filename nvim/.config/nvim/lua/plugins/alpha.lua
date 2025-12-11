return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    -- local dashboard = require("alpha.themes.startify")

    dashboard.section.header.val = {
      "                               ....                                         ",
      "                            ,;;'''';;,                    ,;;;;,            ",
      "                  ,        ;;'      `;;,               .,;;;'   ;           ",
      "               ,;;;       ;;          `;;,';;;,.     ,%;;'     '            ",
      "             ,;;,;;       ;;         ,;`;;;, `;::.  %%;'                    ",
      "            ;;;,;;;       `'       ,;;; ;;,;;, `::,%%;'                     ",
      "            ;;;,;;;,          .,%%%%%'% ;;;;,;;   %;;;                      ",
      "  ,%,.      `;;;,;;;,    .,%%%%%%%%%'%; ;;;;;,;;  %;;;                      ",
      " ;,`%%%%%%%%%%`;;,;;'%%%%%%%%%%%%%'%%'  `;;;;;,;, %;;;                      ",
      " ;;;,`%%%%%%%%%%%,; ..`%%%%%%%%;'%%%'    `;;;;,;; %%;;                      ",
      "  `;;;;;,`%%%%%,;;/, .. `''''',%%%%%      `;;;;;; %%;;,                     ",
      "     `;;;;;;;,;;/////,.    ,;%%%%%%%        `;;;;,`%%;;                     ",
      "            ;;;/%%%%,%///;;;';%%%%%%,          `;;;%%;;,                    ",
      "           ;;;/%%%,%%%%%/;;;';;'%%%%%,             `%%;;                    ",
      "          .;;/%%,%%%%%//;;'  ;;;'%%%%%,             %%;;,                   ",
      "          ;;//%,%%%%//;;;'   `;;;;'%%%%             `%;;;                   ",
      "          ;;//%,%//;;;;'      `;;;;'%%%              %;;;,                  ",
      "          `;;//,/;;;'          `;;;'%%'              `%;;;                  ",
      "            `;;;;'               `;'%'                `;;;;                 ",
      "                                   '      .,,,.        `;;;;                ",
      "                                       ,;;;;;;;;;;,     `;;;;               ",
      "                                      ;;;'    ;;;,;;,    `;;;;              ",
      "                                      ;;;      ;;;;,;;.   `;;;;             ",
      "                                       `;;      ;;;;;,;;   ;;;;             ",
      "                                         `'      `;;;;,;;  ;;;;             ",
      "                                                    `;;,;, ;;;;             ",
      "                                                       ;;, ;;;;             ",
      "                                                         ';;;;;             ",
      "                                                          ;;;;;             ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("Cntl+n", "  > File explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("Cntl+p", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("Space fr", "  > Find Recent", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("Cntl+l", "󰛢  > Harpoon", ""),

      dashboard.button(":checkhealth", "󱃫  > Health Check", "<cmd>qa<CR>"),
      dashboard.button("q", "  > Quit", "<cmd>qa<CR>"),
    }

    alpha.setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
