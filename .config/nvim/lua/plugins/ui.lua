return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            highlight = "background",
          },
        },
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
      scroll = { enabled = false },
      terminal = {
        win = {
          wo = {
            winbar = "",
          },
        },
      },
    },
  },
}
