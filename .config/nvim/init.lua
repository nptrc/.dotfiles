vim.g.mapleader = " "

local github = function(name)
  return "https://github.com/" .. name
end

vim.pack.add({
  { src = github("nvim-lua/plenary.nvim") },

  { src = github("catppuccin/nvim"), name = "catppuccin" },

  { src = github("echasnovski/mini.nvim") },
  { src = github("nvim-tree/nvim-tree.lua") },

  { src = github("nvim-treesitter/nvim-treesitter"), version = "main" },

  { src = github("mason-org/mason.nvim") },
  { src = github("neovim/nvim-lspconfig") },
  { src = github("stevearc/conform.nvim") },
  { src = github("Saghen/blink.cmp") },
  { src = github("Civitasv/cmake-tools.nvim") },

  { src = github("windwp/nvim-autopairs") },
})

require("config.options")
require("config.autocmds")

require("plugins.treesitter")

vim.schedule(function()
  require("config.keymaps")

  require("plugins.lsp")
  require("plugins.mini")
  require("plugins.later")
end)

vim.cmd.colorscheme("catppuccin")
