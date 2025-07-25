later(function()
  add("folke/snacks.nvim")

  local snacks = require("snacks")

  local map = vim.keymap.set

  map("n", "<leader>bd", snacks.bufdelete.delete, { desc = "Delete current buffer" })
  map("n", "<leader>bo", snacks.bufdelete.other, { desc = "Delete others buffers" })
  map("n", "<leader>bD", snacks.bufdelete.all, { desc = "Delete all buffers" })

  map("n", "<leader>e", snacks.explorer.open, { desc = "File Explorer" })
  map("n", "<leader>gg", snacks.lazygit.open, { desc = "Lazygit" })

  -- stylua: ignore start
  map("t", "<c-/>", "<cmd>close<cr>", { desc = "Toggle Terminal" })
  map("n", "<c-/>", function() snacks.terminal() end, { desc = "Toggle Terminal" })
  snacks.toggle.option("spell"):map("<leader>us")
  snacks.toggle.option("wrap"):map("<leader>uw")
  snacks.toggle.diagnostics():map("<leader>ud")

  map("n", "<leader>n", function() snacks.picker.notifications() end, { desc = "Notification History"  })

  map("n", "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File"  })
  map("n", "<leader>ff", function() snacks.picker.files() end, { desc = "Find Files"  })

  map("n", "<leader>sb", function() snacks.picker.lines() end, { desc = "Buffer Lines"  })
  map("n", "<leader>sg", function() snacks.picker.grep() end, { desc = "Grep"  })
  map("n", "<leader>sw", function() snacks.picker.grep_word() end, { desc = "Visual selection or word" } )
  map("n", "<leader>sh", function() snacks.picker.help() end, { desc = "Help Pages"  })
  map("n", "<leader>sH", function() snacks.picker.highlights() end, { desc = "Highlights"  })
  map("n", "<leader>si", function() snacks.picker.icons() end, { desc = "Icons"  })
  map("n", "<leader>sk", function() snacks.picker.keymaps() end, { desc = "Keymaps"  })
  map("n", "<leader>sm", function() snacks.picker.man() end, { desc = "Man Pages"  })
  map("n", "<leader>su", function() snacks.picker.undo() end, { desc = "Undo History"  })
  -- stylua: ignore end

  snacks.setup({
    bigfile = {},
    image = {},

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
              height = 0.99,
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
  })
end)
