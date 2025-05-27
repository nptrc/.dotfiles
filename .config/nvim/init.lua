require("config.lazy")

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
vim.print = _G.dd
