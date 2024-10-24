return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, conf)
    local actions = require "telescope.actions"

    return vim.tbl_deep_extend("force", conf, {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
          },
        },
      },
    })
  end,
}
