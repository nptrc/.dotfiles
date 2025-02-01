return {
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
      scroll = { enabled = false },
      terminal = {
        win = {
          wo = {
            winbar = "",
          },
        },
      },
      picker = {
        hidden = true,
      },
    },
  },
}
