return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "clang-format",
          "cmakelang",
          "ruff",
        },
      },
    },
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "ruff_format" },
      },
    },
  },
}
