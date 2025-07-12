local g = vim.g
local opt = vim.opt

g.snacks_animate = false

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.iskeyword:append("-")
opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"

vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wqa wqa")
vim.cmd("cnoreabbrev WQ wq")
