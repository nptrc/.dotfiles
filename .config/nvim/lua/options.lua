require "nvchad.options"

local o = vim.o

o.wrap = false

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2

vim.cmd [[
  cnoreabbrev W w
  cnoreabbrev Q q
]]
