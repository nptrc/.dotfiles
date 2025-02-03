local map = vim.keymap.set

map("i", "jk", "<esc>", { desc = "Exit insert mode" })

map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "Copy whole file" })
