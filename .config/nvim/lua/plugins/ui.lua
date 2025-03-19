return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {},
    },
  },

  {
    "folke/noice.nvim",
    opts = {
      views = {
        popup = { border = { style = vim.g.border_style } },
        cmdline_popup = { border = { style = vim.g.border_style } },
        cmdline_popupmenu = { border = { style = vim.g.border_style } },
      },
    },
  },
}
