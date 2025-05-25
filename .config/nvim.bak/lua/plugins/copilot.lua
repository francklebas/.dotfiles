return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = false, -- on laisse copilot-cmp gérer les suggestions
      },
      panel = {
        enabled = false, -- pas besoin du panneau latéral
      },
      filetypes = {
        markdown = true,
        yaml = true,
        lua = true,
        javascript = true,
        typescript = true,
        vue = true,
        html = true,
        css = true,
        scss = true,
      },
    })
  end,
}
