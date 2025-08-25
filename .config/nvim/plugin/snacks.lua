later(function()
  local snacks = require("snacks")

  local map = vim.keymap.set

-- stylua: ignore start
map("n", "<leader>bd", snacks.bufdelete.delete)
map("n", "<leader>bo", snacks.bufdelete.other)
map("n", "<leader>bD", snacks.bufdelete.all)

map("n", "<leader>e", snacks.explorer.open)
map("n", "<leader>gg", snacks.lazygit.open)

map("t", "<c-/>", "<cmd>close<cr>")
map("n", "<c-/>", function() snacks.terminal() end)

map("n", "<leader>ff", function() snacks.picker.files() end)
map("n", "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end)

map("n", "<leader>sb", function() snacks.picker.lines() end)
map("n", "<leader>sg", function() snacks.picker.grep() end)
map("n", "<leader>sh", function() snacks.picker.help() end)
map("n", "<leader>sH", function() snacks.picker.highlights() end)
map("n", "<leader>sk", function() snacks.picker.keymaps() end)
map("n", "<leader>sm", function() snacks.picker.man() end)
map("n", "<leader>su", function() snacks.picker.undo() end)
  -- stylua: ignore end

  snacks.setup({
    terminal = {
      win = {
        position = "bottom",
        border = "none",
        height = 0.5,
        wo = {
          winbar = "",
        },
      },
    },

    lazygit = {
      win = {
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
        default = {
          layout = {
            position = "bottom",
            box = "horizontal",
            height = 0.5,
            {
              box = "vertical",
              { win = "input", height = 1 },
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
            { win = "list" },
          },
        },
      },
    },
  })
end)
