return {
  { "folke/ts-comments.nvim", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "nvim-mini/mini.pairs",
    opts = {
      modes = { command = false },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clang-format",
        "ruff",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = false,
        virtual_text = false,
      },
      inlay_hints = {
        enabled = false,
      },
      servers = {
        clangd = { enabled = vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 0 },
        ccls = {
          enabled = vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 1,
          init_options = {
            diagnostics = {
              onChange = 100,
            },
          },
        },
        ruff = { enabled = false },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        cmake = { "cmake_format" },
        python = { "ruff_format" },
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<c-o>"] = { "select_and_accept", "fallback" },
        ["<c-j>"] = { "select_next", "fallback" },
        ["<c-k>"] = { "select_prev", "fallback" },
      },
      completion = {
        documentation = { auto_show = false },
        ghost_text = { enabled = false },
      },
    },
  },

  {
    "folke/snacks.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>sm", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sM", function() Snacks.picker.marks() end, desc = "Marks" },
    },
    opts = {
      indent = { enabled = false },

      dashboard = {
        preset = {
          -- stylua: ignore
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },

      terminal = {
        win = {
          border = "single",
          wo = {
            winbar = "",
          },
        },
      },

      lazygit = {
        win = {
          border = "none",
          position = "float",
          height = 0.99,
          width = 0,
        },
      },

      picker = {
        sources = {
          files = {
            hidden = true,
          },
          explorer = {
            hidden = true,
          },
        },
        win = {
          input = {
            keys = {
              ["<c-o>"] = { "confirm", mode = { "n", "i" } },
            },
          },
        },
        layouts = {
          sidebar = {
            layout = {
              width = 30,
              position = "left",
              box = "vertical",
              { win = "list" },
            },
          },
        },
      },
    },
  },

  {
    "Civitasv/cmake-tools.nvim",
    opts = {
      cmake_build_directory = "build",
    },
  },
}
