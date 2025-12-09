require("oil").setup({
  keymaps = {
    ["l"] = "actions.select",
    ["h"] = { "actions.parent", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["-"] = { "actions.open_cwd", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g?"] = { "actions.show_help", mode = "n" },
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
