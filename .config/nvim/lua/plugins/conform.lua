return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "ruff_format" },
      json = { "prettierd" },
      sh = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
  },
}
