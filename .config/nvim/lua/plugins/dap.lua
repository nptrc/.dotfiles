return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<f10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<f11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<f12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
  },
}
