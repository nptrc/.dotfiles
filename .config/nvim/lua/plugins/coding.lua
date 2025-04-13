return {
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

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { fast_wrap = {} },
  },

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    lazy = false,
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      set({ "n", "x" }, "<c-n>", function()
        mc.matchAddCursor(1)
      end)
      set({ "n", "x" }, "<c-m>", function()
        mc.matchAddCursor(-1)
      end)
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      set("x", "S", mc.splitCursors)
      set("x", "M", mc.matchCursors)
      set("n", "<leader>gv", mc.restoreCursors)
      set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)

      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)

      mc.addKeymapLayer(function(layerSet)
        set("n", "<leader>a", mc.alignCursors)
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
        set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
        set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
    end,
  },
}
