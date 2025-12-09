vim.g.mapleader = " "

require("options")
require("keymaps")
require("autocmds")

vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/nvim-lua/plenary.nvim",
}, { confirm = false })

require("mason").setup()

require("neogit").setup()
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")
