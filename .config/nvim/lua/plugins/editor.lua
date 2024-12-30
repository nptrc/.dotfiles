return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    },
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

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>sW", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
      { "<leader>sw", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
    },
  },

  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_build_directory = "build/",
      cmake_soft_link_compile_commands = false,
    },
  },
}
