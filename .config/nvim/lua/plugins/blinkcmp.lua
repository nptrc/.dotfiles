return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-o>"] = { "show", "hide_documentation" },
      },

      accept = {
        auto_brackets = { enabled = true },
      },

      trigger = {
        signature_help = { enabled = true },
      },

      windows = {
        documentation = {
          auto_show = true,
          direction_priority = {
            autocomplete_north = { "e", "w" },
            autocomplete_south = { "e", "w" },
          },
        },
      },
    },
  },
}
