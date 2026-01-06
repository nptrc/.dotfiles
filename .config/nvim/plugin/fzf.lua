require("fzf-lua").setup({
  winopts = {
    width = 1,
    height = 0.5,
    row = 1,
    border = "none",
    preview = {
      hidden = true,
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
map("n", "<leader>ld", "<cmd>FzfLua lsp_workspace_diagnostics<cr>")
map("n", "<leader>lr", "<cmd>FzfLua lsp_references<cr>")
