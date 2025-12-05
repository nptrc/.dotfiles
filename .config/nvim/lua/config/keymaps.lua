local map = vim.keymap.set

map("i", "jk", "<esc>")
map("t", "<c-,>", "<c-\\><c-n>")

map("n", "<c-c>", "<cmd>%y+<cr>")

map("n", "<a-k>", "<cmd>resize +2<cr>")
map("n", "<a-j>", "<cmd>resize -2<cr>")
map("n", "<a-h>", "<cmd>vertical resize -2<cr>")
map("n", "<a-l>", "<cmd>vertical resize +2<cr>")
