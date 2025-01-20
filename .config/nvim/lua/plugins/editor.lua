return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        indent = {
          with_expanders = false,
          with_markers = false,
        },
        file_size = { enabled = true },
        type = { enabled = true },
        last_modified = { enabled = true },
        created = { enabled = true },
      },
      window = {
        width = 27,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
    },
  },
}
