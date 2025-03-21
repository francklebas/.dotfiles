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

lspconfig.tsserver.setup({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- Exclure les fichiers .vue
  on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype == "vue" then
      client.stop()
    end
  end,
})
