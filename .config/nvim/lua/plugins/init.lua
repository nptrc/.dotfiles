return {
  { "catppuccin/nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = { { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" } },
  },

  {
    "folke/noice.nvim",
    opts = {
      lsp = { signature = { enabled = false } },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clang-format",
        "ruff",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "cmake_format" },
        python = { "ruff_format" },
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<c-o>"] = { "select_and_accept", "fallback" },
        ["<c-j>"] = { "select_next", "fallback" },
        ["<c-k>"] = { "select_prev", "fallback" },
        ["<c-s>"] = { "show_signature", "hide_signature", "fallback" },
      },
      completion = {
        documentation = { auto_show = false },
        list = { selection = { preselect = false } },
      },
      signature = { enabled = true },
    },
  },

  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_build_directory = "build",
      cmake_compile_commands_options = {
        action = "lsp",
      },
    },
  },
}
