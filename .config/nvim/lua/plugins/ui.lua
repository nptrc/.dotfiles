return {
  {
    "snacks.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>sm", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sM", function() Snacks.picker.marks() end, desc = "Marks" },
    },
    opts = {
      dashboard = {
        preset = {
          header = [[

███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

Code or Die :)]],
          -- stylua: ignore
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },

      terminal = {
        win = {
          position = "float",
          border = "none",
          height = 0,
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
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              {
                box = "vertical",
                border = "none",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list" },
              },
              { win = "preview", title = "{preview}", border = "left", width = 0.6 },
            },
          },
          sidebar = {
            layout = {
              width = 30,
              position = "left",
              box = "vertical",
              { win = "list", border = "none" },
            },
          },
        },
      },
    },
  },
}
