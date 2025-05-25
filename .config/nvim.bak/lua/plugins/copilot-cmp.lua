return {
  "hrsh7th/nvim-cmp",
  dependencies = { "zbirenbaum/copilot-cmp" },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      sources = cmp.config.sources({
        { name = "copilot", priority = 1000 },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
      }),
    })
  end,
}
