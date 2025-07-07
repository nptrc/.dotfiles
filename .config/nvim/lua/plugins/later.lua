require("nvim-autopairs").setup({ fast_wrap = {} })

require("blink.cmp").setup({
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    trigger = {
      show_on_trigger_character = true,
    },
    list = {
      selection = {
        preselect = false,
      },
    },
  },
  signature = { enabled = true },

  keymap = {
    preset = "enter",
    ["<cr>"] = { "select_and_accept", "fallback" },
    ["<c-o>"] = { "select_and_accept", "fallback" },
    ["<c-k>"] = { "select_prev", "fallback" },
    ["<c-j>"] = { "select_next", "fallback" },
  },

  cmdline = { enabled = false },
})

require("cmake-tools").setup({
  cmake_build_directory = "build",
  cmake_compile_commands_options = { action = "lsp" },
  cmake_generate_options = { "-GNinja", "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
})
