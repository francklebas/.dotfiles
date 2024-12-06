-- lua/plugins/copilot.lua
return {
  -- Copilot.lua configuration
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "<M-,>", -- Alt + virgule
            jump_next = "<M-;>", -- Alt + point-virgule
            accept = "<CR>",
            refresh = "gr",
            open = "<M-p>", -- Alt + p comme "panel"
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            -- Touches plus accessibles sur AZERTY
            accept = "<M-o>", -- Alt + o (facile à atteindre)
            accept_word = "<M-k>", -- Alt + k
            accept_line = "<M-l>", -- Alt + l
            next = "<M-n>", -- Alt + n (comme "next")
            prev = "<M-p>", -- Alt + p (comme "previous")
            dismiss = "<C-e>", -- Ctrl + e (comme "escape")
          },
        },
        filetypes = {
          javascript = true,
          typescript = true,
          vue = true,
          css = true,
          html = true,
          json = true,
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      })
    end,
  },

  -- Copilot cmp source
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua", "hrsh7th/nvim-cmp" },
    config = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling",
        formatters = {
          label = require("copilot_cmp.format").format_label_text,
          insert_text = require("copilot_cmp.format").format_insert_text,
          preview = require("copilot_cmp.format").deindent,
        },
        mapping = {
          -- Vous pouvez ajouter des mappings spécifiques pour cmp ici
        },
      })

      -- Configuration supplémentaire pour une meilleure expérience
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.completionProvider then
            vim.bo[args.buf].omnifunc = nil
          end
        end,
      })
    end,
  },
}
