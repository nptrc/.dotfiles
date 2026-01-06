local oil = require("oil")

oil.setup({
  keymaps = {
    ["l"] = "actions.select",
    ["h"] = { "actions.parent", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g?"] = { "actions.show_help", mode = "n" },
    ["gy"] = {
      callback = function()
        local entry = oil.get_cursor_entry()
        local dir = oil.get_current_dir()
        if not entry or not dir then
          return
        end
        local relpath = vim.fn.fnamemodify(dir, ":.")
        vim.fn.setreg("+", relpath .. entry.name)
        vim.print(relpath .. entry.name)
      end,
    },
  },
  columns = {
    "permissions",
    "size",
    "mtime",
  },
  delete_to_trash = true,
  watch_for_changes = true,
  view_options = { show_hidden = true },
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")
