local opt = vim.opt
local g = vim.g

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
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

opt.mouse = "a"
opt.autowrite = true
opt.confirm = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"

opt.timeoutlen = 300
opt.updatetime = 200

opt.undofile = true
opt.undolevels = 10000

vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wqa wqa")
vim.cmd("cnoreabbrev WQ wq")

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.loaded_2html_plugin = 1
g.loaded_tohtml = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_matchit = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tutor = 1
g.loaded_rplugin = 1
g.loaded_syntax = 1
g.loaded_synmenu = 1
g.loaded_optwin = 1
g.loaded_compiler = 1
g.loaded_bugreport = 1
g.loaded_ftplugin = 1
