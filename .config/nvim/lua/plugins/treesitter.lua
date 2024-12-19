return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "folke/ts-comments.nvim", opts = {} },
  },
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "cmake",
      "python",
      "json5",
      "markdown",
      "markdown_inline",
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-n>",
        node_incremental = "<C-n>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
}
