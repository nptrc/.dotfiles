require "nvchad.options"

local o = vim.o

o.wrap = false

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4

vim.cmd [[
  cnoreabbrev W w
  cnoreabbrev Q q
]]
