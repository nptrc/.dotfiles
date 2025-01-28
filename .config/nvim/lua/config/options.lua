local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.pumblend = 0

vim.cmd([[
  cnoreabbrev W w
  cnoreabbrev Q q
]])
