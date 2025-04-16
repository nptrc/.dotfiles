return {
  "folke/snacks.nvim",
  opts = {
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
              border = vim.g.border_style,
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = vim.g.border_style, width = 0.6 },
          },
        },
        sidebar = {
          preview = "main",
          layout = {
            width = 30,
            min_width = 30,
            height = 0,
            position = "left",
            border = "none",
            box = "vertical",
            {
              win = "input",
              height = 1,
              border = vim.g.border_style,
              title = "{title} {live} {flags}",
              title_pos = "center",
            },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          },
        },
        telescope = {
          reverse = true,
          layout = {
            box = "horizontal",
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "list", title = " Results ", title_pos = "center", border = vim.g.border_style },
              {
                win = "input",
                height = 1,
                border = vim.g.border_style,
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.45,
              border = vim.g.border_style,
              title_pos = "center",
            },
          },
        },
        ivy = {
          layout = {
            box = "vertical",
            row = -1,
            width = 0,
            height = 0.4,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, border = "left" },
            },
          },
        },
        ivy_split = {
          preview = "main",
          layout = {
            box = "vertical",
            width = 0,
            height = 0.4,
            position = "bottom",
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, border = "left" },
            },
          },
        },
        dropdown = {
          layout = {
            row = 1,
            width = 0.4,
            min_width = 80,
            height = 0.8,
            border = "none",
            box = "vertical",
            { win = "preview", title = "{preview}", height = 0.4, border = vim.g.border_style },
            {
              box = "vertical",
              border = vim.g.border_style,
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
        vertical = {
          layout = {
            width = 0.5,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            border = vim.g.border_style,
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          },
        },
        select = {
          preview = false,
          layout = {
            width = 0.5,
            min_width = 80,
            height = 0.4,
            min_height = 3,
            box = "vertical",
            border = vim.g.border_style,
            title = "{title}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          },
        },
        vscode = {
          preview = false,
          layout = {
            row = 1,
            width = 0.4,
            min_width = 80,
            height = 0.4,
            border = "none",
            box = "vertical",
            {
              win = "input",
              height = 1,
              border = vim.g.border_style,
              title = "{title} {live} {flags}",
              title_pos = "center",
            },
            { win = "list", border = "hpad" },
            { win = "preview", title = "{preview}", border = vim.g.border_style },
          },
        },
      },
    },
  },
}
