return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
    },
    opts = {
      hide_root_node = true,
      default_component_configs = {
        icon = {
          folder_open = "",
          folder_closed = "",
          folder_empty = "",
        },
        file_size = {
          enabled = false,
        },
        type = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
      },
      window = {
        width = 25,
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
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        prompt_prefix = "   ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
          },
        },
      })
    end,
  },

  {
    "CRAG666/code_runner.nvim",
    keys = {
      { "<leader>cb", "<Cmd>RunCode<Cr>", desc = "Code Runner" },
    },
    opts = {
      mode = "float",
      startinsert = true,
      float = {
        border = "rounded",
      },
    },
  },
}
