local map = vim.keymap.set

map("i", "jk", "<esc>", { desc = "Exit Insert Mode" })
map("t", "<c-,>", "<c-\\><c-n>", { desc = "Exit Terminal Mode" })

map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "Copy Whole File" })

map("n", "<c-b>", "<cmd>Task run<cr>", { desc = "Task Run" })
map("n", "<leader>cb", "<cmd>Task build<cr>", { desc = "Task Build" })
map("n", "<leader>fs", "<cmd>Task<cr>", { desc = "Task Manager" })
