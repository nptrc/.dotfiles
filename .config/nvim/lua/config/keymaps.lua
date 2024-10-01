local map = vim.keymap.set

-- Back to normal mode
map("i", "jk", "<Esc>")
map("t", "jk", "<C-\\><C-n>")

-- Split window
map("n", "ss", ":sp<Cr>")
map("n", "sv", ":vs<Cr>")

-- Navigate window
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Indent line
map("n", "<", "<<")
map("n", ">", ">>")
