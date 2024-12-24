return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      "mason.nvim",
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
        cmake = { "cmake_format" },
        python = { "ruff_format" },
      },
    },
  },
}
