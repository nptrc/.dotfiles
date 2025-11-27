return {
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
