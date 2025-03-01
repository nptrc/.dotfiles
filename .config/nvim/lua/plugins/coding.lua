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
}
