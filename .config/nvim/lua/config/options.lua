local opt = vim.opt

vim.g.snacks_animate = false
vim.g.border_style = "single"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.pumblend = 0
opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"

vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wqa wqa")
vim.cmd("cnoreabbrev WQ wq")
