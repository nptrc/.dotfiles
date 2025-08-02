local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.smartindent = true

opt.smartcase = true
opt.ignorecase = true

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"

opt.scrolloff = 4
opt.sidescrolloff = 8

opt.wrap = false
opt.linebreak = true
opt.laststatus = 3
opt.pumheight = 10
opt.showmode = false
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.guicursor = "n-v-c-sm-i-ci-ve-r-cr-o:block"
opt.shortmess:append({ I = true, c = true })
opt.iskeyword:append("-")

opt.autowrite = true
opt.confirm = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.virtualedit = "block"

opt.timeoutlen = 300
opt.updatetime = 200

opt.undofile = true
