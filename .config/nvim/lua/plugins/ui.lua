return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            highlight = "Directory",
            text_align = "center",
            text = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
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
    "snacks.nvim",
    opts = {
      indent = { enabled = false },
    },
  },
}
