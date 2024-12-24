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
}
