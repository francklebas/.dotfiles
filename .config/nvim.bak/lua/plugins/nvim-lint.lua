return {
  "mfussenegger/nvim-lint",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      vue = { "eslint" },
      js = { "eslint" },
      jsx = { "eslint" },
      ts = { "eslint" },
      tsx = { "eslint" },
    },
  },
}
