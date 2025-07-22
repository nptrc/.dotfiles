return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<f10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<f11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<f12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
    opts = function()
      local dap = require("dap")
      dap.adapters.codelldb = nil
      dap.configurations.c = nil
      dap.configurations.cpp = nil

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "OpenDebugAD7",
      }
    end,
  },
}
