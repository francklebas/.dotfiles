return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Désactiver le comportement par défaut de Tab
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true

    -- Activer Copilot uniquement pour certains types de fichiers
    vim.g.copilot_filetypes = {
      markdown = true,
      yaml = true,
      lua = true,
      javascript = true,
      typescript = true,
      vue = true,
      html = true,
      css = true,
      scss = true,
    }

    -- Utiliser Tab pour accepter les suggestions
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("")', { expr = true, silent = true, noremap = true })
  end,
}
