return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "clang-format",
            "prettierd",
          },
        },
      },
    },
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "cmake_format" },
        rust = { "rustfmt" },
        python = { "ruff_format" },
      },
      formatters = {
        prettier = {
          command = vim.fn.stdpath("data") .. "/mason/bin/prettierd",
        },
      },
    },
  },
}
