local map = vim.keymap.set

map("i", "jk", "<esc>", { desc = "Exit Insert Mode" })
map("t", "<c-,>", "<c-\\><c-n>", { desc = "Exit Terminal Mode" })

map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "Copy Whole File" })
map({ "n" }, "<c-s>", "<cmd>w ++p<cr><esc>", { desc = "Save File" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

map("n", "j", "gj", { desc = "Down" })
map("n", "k", "gk", { desc = "Up" })

map("n", "<c-h>", "<c-w>h", { desc = "Go to Left Window" })
map("n", "<c-j>", "<c-w>j", { desc = "Go to Lower Window" })
map("n", "<c-k>", "<c-w>k", { desc = "Go to Upper Window" })
map("n", "<c-l>", "<c-w>l", { desc = "Go to Right Window" })

map("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<S-l>", "<cmd>bn<cr>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>bp<cr>", { desc = "Prev Buffer" })

map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

map("v", "<", "<gv", { desc = "Better indenting" })
map("v", ">", ">gv", { desc = "Better indenting" })

map("n", "<c-b>", function()
  require("customs.taskrunner").new("run")
end, { desc = "Task Run" })
map("n", "<leader>cb", function()
  require("customs.taskrunner").new("build")
end, { desc = "Task Build" })
map("n", "<leader>fs", function()
  require("customs.taskrunner").new()
end, { desc = "Task Manager" })
