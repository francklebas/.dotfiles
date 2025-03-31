local lspconfig = require("lspconfig")

lspconfig.volar.setup({
  filetypes = { "vue", "javascript", "typescript", "css", "scss" },
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
  init_options = {
    typescript = {
      tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
    },
  },
})

lspconfig.ts_ls.setup({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- Exclure les fichiers .vue
  on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype == "vue" then
      client.stop()
    end
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  end,
  init_options = {
    preferences = {
      includeCompletionsForModuleExports = true,
      includeCompletionsWithInsertText = true,
    },
    plugins = {
      {
        name = "@adonisjs/ts-plugin",
        location = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules", -- adapte si besoin
      },
    },
  },
})
