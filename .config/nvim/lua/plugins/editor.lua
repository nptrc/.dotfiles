return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      default_component_configs = {
        indent = { with_expanders = false },
        file_size = { enabled = false },
        type = { enabled = false },
        last_modified = { enabled = false },
      },
      window = {
        width = 25,
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
    cmd = "RunCode",
    keys = {
      { "<C-b>", "<Cmd>RunCode<Cr>", desc = "Code Runner" },
    },
    opts = {
      mode = "float",
      startinsert = true,
      term = {
        size = 10,
      },
      float = {
        border = "rounded",
      },
      filetype = {
        python = "python -u $fileName",
        c = {
          "cd $dir",
          "&& gcc $fileName -o /tmp/$fileNameWithoutExt -Wall -lm",
          "&& /tmp/$fileNameWithoutExt",
          "&& rm /tmp/$fileNameWithoutExt",
        },
        cpp = {
          "cd $dir",
          "&& g++ $fileName -o /tmp/$fileNameWithoutExt -Wall",
          "&& /tmp/$fileNameWithoutExt",
          "&& rm /tmp/$fileNameWithoutExt",
        },
      },
    },
  },
}
