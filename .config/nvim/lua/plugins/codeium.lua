return {
  "Exafunction/codeium.nvim",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      enable_chat = true,
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = "<M-o>", -- Alt + o (facile à atteindre)
          accept_word = "<M-k>", -- Alt + k
          accept_line = "<M-l>", -- Alt + l
          next = "<M-n>", -- Alt + n (comme "next")
          prev = "<M-p>", -- Alt + p (comme "previous")
          clear = "<C-e>", -- Ctrl + e (comme "escape")
        },
      },
    }, require("config.codeium"))
  end,
}
