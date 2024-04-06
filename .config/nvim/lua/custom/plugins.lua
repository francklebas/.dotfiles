local plugins = {
  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    opts = function ()
      return require "custom.configs.copilot"
    end,
    config = function(_, opts)
      require("copilot").setup(opts)
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "css-lsp",
        "eslint_d",
        "html-lsp",
        "json-lsp",
        "prettier",
        "python-lsp-server",
        "vetur-vls",
        "vue-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
}
return plugins
