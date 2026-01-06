vim.g.mapleader = " "

require("options")
require("keymaps")
require("autocmds")

vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
}, { confirm = false })

vim.cmd.colorscheme("miniwinter")
require("mini.ai").setup()
require("mini.surround").setup()
vim.keymap.set("n", "<leader>bd", "<cmd>lua require('mini.bufremove').delete(0)<cr>")

require("mason").setup()

require("neogit").setup()
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")

require("blink.cmp").setup({
  keymap = {
    ["<cr>"] = { "select_and_accept", "fallback" },
  },
  completion = {
    list = {
      selection = { preselect = false },
    },
  },
})
