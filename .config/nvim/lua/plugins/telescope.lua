-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>fw",
      function()
        -- Récupère le mot complet sous le curseur, y compris avec tirets
        local word = vim.fn.expand("<cWORD>")
        -- Extrait seulement le nom de classe (sans attributs/guillemets)
        word = word:match("([%w%-_]+)")
        -- Appelle directement ripgrep via Telescope
        vim.cmd("Telescope grep_string search=" .. word)
      end,
      desc = "Find Word Under Cursor",
    },
  },
}
