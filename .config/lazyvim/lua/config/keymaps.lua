local map = vim.keymap.set

map("i", "jk", "<esc>", { desc = "Back to normal mode" })

map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "Copy whole file" })

map("n", "<c-b>", "<cmd>Task run<cr>")
map("n", "<leader>cb", "<cmd>Task build<cr>")
map("n", "<leader>fs", "<cmd>Task<cr>")
