return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  -- stylua: ignore
  keys = {
    { "<leader>bd", function() Snacks.bufdelete() end },
    { "<leader>e", function() Snacks.explorer() end },
    { "<leader>gg", function() Snacks.lazygit() end },

    { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end },

    { "<leader>sg", function() Snacks.picker.grep() end },
    { "<leader>sw", function() Snacks.picker.grep_word() end },
    { "<leader>sb", function() Snacks.picker.lines() end },
    { "<leader>sh", function() Snacks.picker.help() end },
    { "<leader>sk", function() Snacks.picker.keymaps() end },
    { "<leader>sm", function() Snacks.picker.man() end },
  },
  opts = {
    explorer = {},
    bigfile = {},
    indent = {},
    quickfile = {},
    input = {},
    picker = {
      hidden = true,
    },
  },
}
