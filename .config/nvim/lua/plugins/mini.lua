return {
  "echasnovski/mini.nvim",
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup()
    require("mini.bufremove").setup()
    require("mini.pairs").setup()
  end,
}
