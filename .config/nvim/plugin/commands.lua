local cmd = vim.api.nvim_create_user_command

cmd("Task", function(opts)
  require("customs.taskrunner").new(opts)
end, { nargs = "?" })
