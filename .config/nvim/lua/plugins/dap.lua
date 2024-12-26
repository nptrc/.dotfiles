return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F10>", "<leader>dO", desc = "Step Over", remap = true },
      { "<F11>", "<leader>di", desc = "Step Into", remap = true },
      { "<S-F11>", "<leader>do", desc = "Step Out", remap = true },
    },
  },
}
