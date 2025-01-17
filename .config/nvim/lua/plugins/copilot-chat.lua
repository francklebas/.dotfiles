-- lua/plugins/copilot-chat.lua
return {
  {
    "jellydn/CopilotChat.nvim",
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace
      debug = false, -- Enable debugging
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt)
      language = "fr", -- Langue par défaut (français)
    },
    build = function()
      vim.defer_fn(function()
        vim.cmd("UpdateRemotePlugins")
      end, 100)
    end,
    event = "VeryLazy",
    keys = {
      -- Ouvrir le chat en mode normal
      { "<leader>cc", ":CopilotChat ", desc = "CopilotChat - Poser une question" },

      -- Chat avec la sélection visuelle
      { "<leader>cv", ":CopilotChatVisual ", desc = "CopilotChat - Discuter de la sélection", mode = "x" },

      -- Commandes rapides en mode normal
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Expliquer le code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "Générer des tests" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "Review de code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fixer le code" },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Optimiser le code" },
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
  },
}
