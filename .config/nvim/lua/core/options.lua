local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true
opt.termguicolors = true
opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"

opt.wrap = false
opt.laststatus = 3
opt.pumheight = 10
opt.signcolumn = "yes"
opt.showmode = false

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

opt.timeoutlen = 300
opt.updatetime = 200

opt.undofile = true
opt.undolevels = 10000

opt.shortmess:append({ I = true })

vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")
