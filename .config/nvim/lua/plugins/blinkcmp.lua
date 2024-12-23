return {
  { "hrsh7th/nvim-cmp", enabled = false },

  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "enter",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-o>"] = { "show", "hide_documentation" },
      },

      sources = {
        cmdline = {},
      },

      signature = { enabled = true },

      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
    },
  },
}
