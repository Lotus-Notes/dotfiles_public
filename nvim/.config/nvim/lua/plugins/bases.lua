return {
  "miller3616/bases.nvim",
  config = function()
    local vault = vim.fn.expand("~/Dropbox/Lotus_Notes/Lotus")

    require("bases").setup({
      vault_path = vault,
    })

    require("bases.engine").init(vault, function(err)
      if err then
        vim.notify("bases.nvim init failed: " .. err, vim.log.levels.ERROR)
      end
    end)
  end,
}
