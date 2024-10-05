local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.pumblend = 0
opt.iskeyword:append("-")

vim.cmd([[
    cnoreabbrev W w
    cnoreabbrev Q q
]])
