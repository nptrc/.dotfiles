later(function()
  require("nvim-autopairs").setup()

  require("conform").setup({
    format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cmake = { "cmake_format" },
      python = { "ruff_format" },
      json = { "prettier" },
      markdown = { "prettier" },
    },
  })

  require("blink.cmp").setup({
    keymap = {
      preset = "enter",
      ["<cr>"] = { "select_and_accept", "fallback" },
      ["<c-o>"] = { "select_and_accept", "fallback" },
      ["<c-j>"] = { "select_next", "fallback" },
      ["<c-k>"] = { "select_prev", "fallback" },
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      list = {
        selection = { preselect = false },
      },
    },
    cmdline = { enabled = false },
  })
end)
