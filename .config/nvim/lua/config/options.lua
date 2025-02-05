local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.pumblend = 0

opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"

vim.cmd([[
  cnoreabbrev W w
  cnoreabbrev Q q
]])
