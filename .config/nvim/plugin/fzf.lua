require("fzf-lua").setup({
  winopts = {
    border = "single",
    fullscreen = true,
    preview = {
      border = "single",
      horizontal = "right:55%",
    },
  },
  files = {
    cwd_prompt = false,
  },
})

local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>FzfLua files<cr>")
map("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>")
map("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>")
map("n", "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>")
map("n", "<leader>sh", "<cmd>FzfLua helptags<cr>")
map("n", "<leader>sm", "<cmd>FzfLua manpages<cr>")
map("n", "<leader>fr", "<cmd>FzfLua resume<cr>")
