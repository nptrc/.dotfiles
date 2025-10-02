local map = vim.keymap.set

map("i", "jk", "<esc>")

map("n", "<c-c>", "<cmd>%y+<cr>")

map("n", "<a-k>", "<cmd>resize +2<cr>")
map("n", "<a-j>", "<cmd>resize -2<cr>")
map("n", "<a-h>", "<cmd>vertical resize -2<cr>")
map("n", "<a-l>", "<cmd>vertical resize +2<cr>")

map("n", "<c-b>", function()
  require("customs.taskrunner").new("run")
end)
map("n", "<leader>cb", function()
  require("customs.taskrunner").new("build")
end)
map("n", "<leader>fs", function()
  require("customs.taskrunner").new()
end)
map("n", "<leader>fl", function()
  require("customs.taskrunner").run_last()
end)
