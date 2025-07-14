return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      skip_unbalanced = false,
    },
  },

  {
    "echasnovski/mini.ai",
    opts = function(_, opts)
      local ai = require("mini.ai")
      opts.custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, { use_nvim_treesitter = true }),
        f = ai.gen_spec.treesitter({
          a = "@function.outer",
          i = "@function.inner",
        }, { use_nvim_treesitter = true }),
      }
    end,
  },

  {
    "Saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<c-o>"] = { "select_and_accept", "fallback" },
        ["<c-j>"] = { "select_next", "fallback" },
        ["<c-k>"] = { "select_prev", "fallback" },
      },

      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
      },
    },
  },
}
