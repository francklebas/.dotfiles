-- lua/plugins/mason.lua
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Web Development
        "eslint-lsp",
        "prettierd",
        "vue-language-server",
        "typescript-language-server",
        "json-lsp",
        "css-lsp",
        "html-lsp",

        -- Python Development
        "pyright", -- LSP Python (Microsoft)
        "ruff-lsp", -- Linter Python ultra rapide
        "black", -- Formateur Python
        "debugpy", -- Debugger Python
        "isort", -- Tri des imports Python
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
    },
  },
}
