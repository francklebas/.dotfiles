-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Front-end existant
      vue = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      javascript = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },

      -- Python
      python = { "black", "isort" },
    },

    formatters = {
      -- Configuration de black
      black = {
        prepend_args = { "--line-length=88" },
      },
      -- Configuration de isort
      isort = {
        prepend_args = { "--profile", "black" },
      },
    },
  },
}
