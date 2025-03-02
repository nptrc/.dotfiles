return {
  {
    "Saghen/blink.cmp",
    opts = {
      enabled = function()
        return not vim.tbl_contains({ "copilot-chat" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
      end,

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

  {
    "echasnovski/mini.pairs",
    enabled = true,
    event = { "VeryLazy" },
    version = "*",
    opts = {
      modes = { insert = true, command = false, terminal = false },

      mappings = {
        ["["] = { action = "open", pair = "[]", neigh_pattern = ".[%s%z%)}%]]", register = { cr = false } },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = ".[%s%z%)}%]]", register = { cr = false } },
        ["("] = { action = "open", pair = "()", neigh_pattern = ".[%s%z%)}%]]", register = { cr = false } },

        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%w\\][^%w]", register = { cr = false } },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w\\][^%w]", register = { cr = false } },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w\\][^%w]", register = { cr = false } },
      },
    },
  },
}
