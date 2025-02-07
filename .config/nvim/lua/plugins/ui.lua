return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      animate = { enabled = false },
      scroll = { enabled = false },
      terminal = { win = { wo = { winbar = "" } } },
      picker = { hidden = true },
    },
  },
}
