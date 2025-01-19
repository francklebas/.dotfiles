-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- Vos mappings existants
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
    end,
    opts = {
      -- Configuration des serveurs LSP
      servers = {
        -- Configuration ESLint
        eslint = {
          settings = {
            -- Désactive le formatage via ESLint (on utilise Prettier)
            format = false,
            -- Lance ESLint à la sauvegarde
            run = "onSave",
            -- Utilise la configuration du projet
            options = {
              useEslintrc = true,
            },
          },
        },

        -- Configuration Python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },

        -- Configuration Ruff (linter Python)
        ruff_lsp = {
          settings = {
            args = {},
          },
        },

        -- tssserver
        tsserver = {
          settings = {
            filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
          },
        },
      },
      setup = {
        eslint = function()
          vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(event)
              -- Correction automatique des erreurs ESLint à la sauvegarde
              if require("lspconfig").util.get_active_client_by_name(event.buf, "eslint") then
                vim.cmd("EslintFixAll")
              end
            end,
          })
        end,
      },
    },
  },

  -- Ajout de Mason pour gérer les LSP servers
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp", -- Pour ESLint
        "vue-language-server", -- Pour Vue
        "typescript-language-server", -- Pour TypeScript
        "prettier", -- Pour le formatage
        "prettierd", -- Version plus rapide de Prettier
      },
    },
  },
}
