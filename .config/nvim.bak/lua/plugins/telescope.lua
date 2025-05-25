return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>vg",
      "require('telescope.builtin').live_grep({prompt_title = 'find string in open buffers...',grep_open_files = true})",
    },
  },
}
