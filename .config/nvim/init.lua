require("config.lazy")

vim.schedule(function()
  for _, plug in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/builtins")) do
    require("builtins." .. plug)
  end
end)
