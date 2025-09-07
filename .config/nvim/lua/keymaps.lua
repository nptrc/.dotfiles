local map = vim.keymap.set

map("i", "jk", "<esc>")
map("t", "<c-,>", "<c-\\><c-n>")

map("n", "<c-c>", "<cmd>%y+<cr>")
map("n", "<c-s>", "<cmd>w ++p<cr><esc>")
map("n", "<leader>qq", "<cmd>qa<cr>")

map("n", "j", "gj")
map("n", "k", "gk")

map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")
map("t", "<c-k>", "<c-\\><c-n><c-w>k")
map("t", "<c-j>", "<c-\\><c-n><c-w>j")
map("t", "<c-h>", "<c-\\><c-n><c-w>h")
map("t", "<c-l>", "<c-\\><c-n><c-w>l")

map("n", "<a-k>", "<cmd>resize +2<cr>")
map("n", "<a-j>", "<cmd>resize -2<cr>")
map("n", "<a-h>", "<cmd>vertical resize -2<cr>")
map("n", "<a-l>", "<cmd>vertical resize +2<cr>")

map("n", "<s-l>", "<cmd>bn<cr>")
map("n", "<s-h>", "<cmd>bp<cr>")

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
map("n", "<leader>cl", function()
  require("customs.taskrunner").run_last()
end)
