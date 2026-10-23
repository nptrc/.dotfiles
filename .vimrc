syntax on
colorscheme evening

let mapleader=" "
let localmapleader="\\"

set confirm
set autowrite
set updatetime=300
set timeoutlen=300
set virtualedit=block
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set wildmenu
set number
set relativenumber
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set shiftround
set smartindent
set expandtab
set splitbelow
set splitright
set splitkeep=screen
set hlsearch
set incsearch
set undofile
set undolevels=10000
set laststatus=3
set noshowmode
set pumheight=10
set guicursor=i-ci-ve:block

inoremap jk <esc>
nnoremap <s-l> :bnext<cr>
nnoremap <s-h> :bprevious<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
