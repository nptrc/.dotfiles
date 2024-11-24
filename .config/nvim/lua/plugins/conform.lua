return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      python = { "ruff_format" },
      markdown = { "prettier" },
    },

    formatters = {
      ["clang-format"] = {
        prepend_args = { "-style", "Microsoft" },
      },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
