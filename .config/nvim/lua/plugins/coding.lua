return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      skip_unbalanced = false,
    },
  },

  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<c-o>"] = { "select_and_accept", "fallback" },
        ["<c-j>"] = { "select_next", "fallback" },
        ["<c-k>"] = { "select_prev", "fallback" },
      },

      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
      },
    },
  },
}
