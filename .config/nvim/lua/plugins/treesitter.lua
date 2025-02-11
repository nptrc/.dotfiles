return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    { "folke/ts-comments.nvim", opts = {} },
    { "windwp/nvim-ts-autotag", opts = {} },
  },
  opts = {
    ensure_installed = "all",
    indent = { enable = true },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
