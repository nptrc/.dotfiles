return {
  {
    "CRAG666/code_runner.nvim",
    keys = {
      { "<leader>cb", "<cmd>RunCode<cr>", desc = "Code Runner", remap = false },
    },
    opts = {
      mode = "tab",
      filetype = {
        c = {
          "cd $dir",
          "&& gcc $fileName -o /tmp/$fileNameWithoutExt -lm",
          "&& /tmp/$fileNameWithoutExt",
          "&& rm /tmp/$fileNameWithoutExt",
        },
      },
    },
  },
}
