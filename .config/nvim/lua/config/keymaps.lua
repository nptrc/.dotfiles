local map = vim.keymap.set

map("i", "jk", "<esc>", { desc = "Exit Insert Mode" })
map("t", "<c-,>", "<c-\\><c-n>", { desc = "Exit Terminal Mode" })

map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "Copy Whole File" })

-- stylua: ignore start
map("n", "<c-b>", function() require("customs.taskrunner").new("run") end, { desc = "Task Run" })
map("n", "<leader>cb", function() require("customs.taskrunner").new("build") end, { desc = "Task Build" })
map("n", "<leader>fs", function() require("customs.taskrunner").new() end, { desc = "Task Manager" })
-- stylua: ignore end
