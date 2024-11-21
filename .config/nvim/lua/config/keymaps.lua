local map = vim.keymap.set

-- back to normal mode
map("i", "jk", "<esc>")
map("t", "jk", "<C-\\><C-n>")

-- don't have to press shift anymore
map("n", ";", ":")

-- navigate window
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- indent line
map("n", "<", "<<")
map("n", ">", ">>")
