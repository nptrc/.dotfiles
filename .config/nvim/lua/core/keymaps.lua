local map = vim.keymap.set

vim.g.mapleader = " "

map("i", "jk", "<esc>")

map("n", "<c-c>", "<cmd>%y+<cr>")

map({ "i", "n" }, "<c-s>", "<cmd>w<cr><esc>")

map("n", "<leader>qq", "<cmd>qa<cr>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

map("n", "<c-up>", "<cmd>resize +2<cr>")
map("n", "<c-down>", "<cmd>resize -2<cr>")
map("n", "<c-left>", "<cmd>vertical resize -2<cr>")
map("n", "<c-right>", "<cmd>vertical resize +2<cr>")

map("n", "<a-j>", "<cmd>execute 'move .+' . v:count1<cr>==")
map("n", "<a-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi")
map("v", "<a-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
map("v", "<a-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")

map("n", "<S-h>", "<cmd>bprevious<cr>")
map("n", "<S-l>", "<cmd>bnext<cr>")

map("n", "<leader>ur", "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>")

map("n", "<leader>K", "<cmd>norm! K<cr>")

vim.keymap.set("n", "<c-b>", "<cmd>Task run<cr>")
vim.keymap.set("n", "<leader>cb", "<cmd>Task build<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Task<cr>")
