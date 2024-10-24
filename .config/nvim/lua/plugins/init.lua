return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvimtree",
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = require "configs.telescope",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = require "configs.cmp",
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "echasnovski/mini.surround",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    opts = true,
  },

  {
    "echasnovski/mini.ai",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    opts = true,
  },
}
