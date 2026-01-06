local map = vim.keymap.set

map("i", "jk", "<esc>")

map("n", "j", "gj")
map("n", "k", "gk")

map("n", "<c-c>", "<cmd>%y+<cr>")
map("n", "<leader>K", "<cmd>norm! K<cr>")

map("x", "<", "<gv")
map("x", ">", ">gv")

map("n", "<s-h>", "<cmd>bprevious<cr>")
map("n", "<s-l>", "<cmd>bnext<cr>")

map("n", "<a-k>", "<cmd>resize +2<cr>")
map("n", "<a-j>", "<cmd>resize -2<cr>")
map("n", "<a-h>", "<cmd>vertical resize -2<cr>")
map("n", "<a-l>", "<cmd>vertical resize +2<cr>")

map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

map("t", "<c-,>", "<c-\\><c-n>")
map("t", "<c-h>", "<c-\\><c-n><c-w>h")
map("t", "<c-j>", "<c-\\><c-n><c-w>j")
map("t", "<c-k>", "<c-\\><c-n><c-w>k")
map("t", "<c-l>", "<c-\\><c-n><c-w>l")

map("n", "<leader>ur", "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>")
