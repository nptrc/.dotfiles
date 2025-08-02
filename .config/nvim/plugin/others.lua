later(function()
  add("nvim-lua/plenary.nvim")

  add("stevearc/conform.nvim")
  require("conform").setup({
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

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(e)
      require("conform").format({ bufnr = e.buf })
    end,
  })

  add({ source = "saghen/blink.cmp", checkout = "v1.6.0" })
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

  add("Civitasv/cmake-tools.nvim")
  require("cmake-tools").setup({
    cmake_build_directory = "build",
    cmake_generate_options = { "-GNinja", "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
  })
end)
