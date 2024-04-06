local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.stylua.with {
      filetypes = { "lua" }
    },
    null_ls.builtins.formatting.prettier.with {
      filetypes = { "javascript", "typescript", "json", "yaml", "html", "css", "scss", "vue" }
    },
    null_ls.builtins.formatting.eslint_d.with {
      filetypes = { "javascript", "typescript", "json", "yaml", "html", "css", "scss", "vue" }
    },
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.formatting_sync() instead
          vim.lsp.buf.format { async = false }
        end,
      })
    end
    -- if client.supports_method("textDocument/formatting") then
    --   vim.api.nvim_clear_autocmds({
    --     group = augroup,
    --     buffer = bufnr,
    --   })
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = augroup,
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = bufnr })
    --     end,
    --   })
    -- end
  end,
}

return opts
