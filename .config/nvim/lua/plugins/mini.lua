return {
  "echasnovski/mini.nvim",
  dependencies = {
    { "nvim-tree/nvim-tree.lua", enabled = false },
  },
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup()
    require("mini.bufremove").setup()
    require("mini.files").setup()
    require("mini.pairs").setup()
  end,
}
