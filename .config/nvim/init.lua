require("config.lazy")

vim.cmd("silent !kitty @ set-spacing padding-left=0 padding-top=0")

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
vim.print = _G.dd
