return {
  "Saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    keymap = {
      preset = "enter",
      ["<cr>"] = { "select_and_accept", "fallback" },
      ["<c-o>"] = { "select_and_accept", "fallback" },
      ["<c-j>"] = { "select_next", "fallback" },
      ["<c-k>"] = { "select_prev", "fallback" },
    },

    cmdline = {
      keymap = {
        ["<c-j>"] = { "select_next", "fallback" },
        ["<c-k>"] = { "select_prev", "fallback" },
        ["<tab>"] = { "select_next", "fallback" },
        ["<s-tab>"] = { "select_prev", "fallback" },
      },
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },

    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = { auto_show = true },
    },

    signature = { enabled = true },
  },
}
