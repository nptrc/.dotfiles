return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        left_trunc_marker = "",
        right_trunc_marker = "",
        always_show_bufferline = true,
        tab_size = 14,
        offsets = {
          {
            filetype = "neo-tree",
            text = function()
              return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            end,
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
  },
}
