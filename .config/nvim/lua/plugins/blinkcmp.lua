return {
  "Saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-o>"] = { "select_and_accept", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-y>"] = { "show", "hide_documentation", "fallback" },
    },

    sources = {
      cmdline = {},
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = { auto_show = true },
    },

    signature = { enabled = true },
  },
}
