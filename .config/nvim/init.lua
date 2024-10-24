vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "bootstrap"
require "options"
require "autocmds"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
