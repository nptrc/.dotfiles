local map = vim.keymap.set

map("i", "jk", "<esc>")
map("t", "<c-,>", "<c-\\><c-n>")

map("n", "<c-c>", "<cmd>%y+<cr>")
map({ "n" }, "<c-s>", "<cmd>w ++p<cr><esc>")
map("n", "<leader>qq", "<cmd>qa<cr>")

map("n", "j", "gj")
map("n", "k", "gk")

map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

map("n", "<a-k>", "<cmd>resize +2<cr>")
map("n", "<a-j>", "<cmd>resize -2<cr>")
map("n", "<a-h>", "<cmd>vertical resize -2<cr>")
map("n", "<a-l>", "<cmd>vertical resize +2<cr>")

map("n", "<S-l>", "<cmd>bn<cr>")
map("n", "<S-h>", "<cmd>bp<cr>")

map("n", "<leader>ur", "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<c-b>", function()
  require("customs.taskrunner").new("run")
end)
map("n", "<leader>cb", function()
  require("customs.taskrunner").new("build")
end)
map("n", "<leader>fs", function()
  require("customs.taskrunner").new()
end)
