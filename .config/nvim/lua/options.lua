local opt = vim.opt

opt.confirm = true
opt.autowrite = true
opt.updatetime = 300
opt.timeoutlen = 300
opt.jumpoptions = "view"
opt.virtualedit = "block"
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"

opt.number = true
opt.relativenumber = true

opt.ignorecase = true
opt.smartcase = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.smartindent = true
opt.expandtab = true

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

opt.undofile = true
opt.undolevels = 10000

opt.laststatus = 3
opt.signcolumn = "yes"
opt.showmode = false
opt.pumheight = 10
opt.termguicolors = true
opt.guicursor = "i-ci-ve:block"
opt.shortmess:append({ I = true, c = true, C = true })
