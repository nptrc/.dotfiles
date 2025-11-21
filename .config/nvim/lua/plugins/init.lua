return {
  { "catppuccin/nvim", enabled = false },
  { "mfussenegger/nvim-lint", enabled = false },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = { { "<leader>gg", "<cmd>Neogit<cr>" } },
  },

  {
    "folke/noice.nvim",
    opts = {
      lsp = { signature = { enabled = false } },
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
      diagnostics = { underline = false },
      inlay_hints = { enabled = false },
      servers = {
        clangd = { enabled = vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 0 },
        ccls = { enabled = vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 1 },
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
        ["<c-s>"] = { "show_signature", "hide_signature", "fallback" },
      },
      completion = {
        documentation = { auto_show = false },
        list = { selection = { preselect = false } },
      },
      signature = { enabled = true },
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
      dashboard = { enabled = false },

      terminal = {
        win = {
          border = "single",
          wo = { winbar = "" },
        },
      },

      picker = {
        win = {
          input = {
            keys = {
              ["<c-o>"] = { "confirm", mode = { "n", "i" } },
            },
          },
        },
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
          explorer = {
            hidden = true,
          },
        },
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              height = 0,
              {
                box = "vertical",
                border = "top",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = "left", width = 0.5 },
            },
          },
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
}
