return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>qs", function() require("persistence").load() end },
    { "<leader>qS", function() require("persistence").select() end },
    { "<leader>qd", function() require("persistence").stop() end },
  },
}
