return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      {
        "mason.nvim",
        opts = {
          ensure_installed = {
            "clang-format",
            "ruff",
          },
        },
      },
    },
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        python = { "ruff_format" },
      },

      formatters = {
        ["clang-format"] = {
          prepend_args = { "-style", "Microsoft" },
        },
      },
    },
  },
}
