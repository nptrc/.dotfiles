local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local mappings = {
    ["l"] = { api.node.open.edit, "Open" },
    ["<Cr>"] = { api.node.open.edit, "Open" },
    ["h"] = { api.node.navigate.parent_close, "Close Directory" },
    ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
    ["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },

    ["a"] = { api.fs.create, "Create" },
    ["r"] = { api.fs.rename, "Rename" },
    ["e"] = { api.fs.rename_basename, "Rename: Basename" },
    ["<C-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
    ["d"] = { api.fs.remove, "Delete" },

    ["x"] = { api.fs.cut, "Cut" },
    ["c"] = { api.fs.copy.node, "Copy" },
    ["y"] = { api.fs.copy.filename, "Copy Name" },
    ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
    ["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
    ["p"] = { api.fs.paste, "Paste" },

    ["I"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
    ["H"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },

    ["g?"] = { api.tree.toggle_help, "Help" },
  }

  for keys, mapping in pairs(mappings) do
    vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
  end
end

return {
  on_attach = on_attach,
  view = {
    width = 25,
    preserve_window_proportions = true,
  },
  git = {
    enable = false,
  },
}
