local builtin_plugins_dir = vim.fn.stdpath("config") .. "/lua/builtin"

return {
  {
    "builtin.taskrunner",
    dir = builtin_plugins_dir,
    cmd = "Task",
    config = function()
      require("builtin.taskrunner")
    end,
  },
}
