return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        win = {
          border = "none",
          height = 0,
          width = 0,
        },
      },

      terminal = {
        win = {
          position = "float",
          border = "single",
          height = 0.9,
          width = 0.8,
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
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.9,
              {
                box = "vertical",
                border = "rounded",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              { win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
            },
          },
          sidebar = {
            layout = {
              width = 30,
            },
          },
        },
      },
    },
  },
}
