return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      tab_size = 14,
      show_close_icon = false,
      show_buffer_close_icons = false,
      left_trunc_marker = "",
      right_trunc_marker = "",
      always_show_bufferline = true,
      diagnostics = false,
      offsets = {
        {
          filetype = "neo-tree",
          text = "",
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
  },
}
