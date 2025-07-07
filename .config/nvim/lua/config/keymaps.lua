local map = vim.keymap.set

map("i", "jk", "<esc>", { desc = "Exit Insert Mode" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<c-c>", "<cmd>%y+<cr>", { desc = "Copy Whole File" })
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>rl", "<cmd>restart<cr>", { desc = "Restart Nvim Server" })

map("n", "j", "gj", { desc = "Down" })
map("n", "<Down>", "gj", { desc = "Down" })
map("n", "k", "gk", { desc = "Up" })
map("n", "<Up>", "gk", { desc = "Up" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

map("n", "<S-l>", "<cmd>bn<cr>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>bp<cr>", { desc = "Prev Buffer" })
map("n", "<leader>bd", function()
  require("customs.bufdelete").delete()
end, { desc = "Delete Buffer" })

map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { desc = "Next Search Result", expr = true })
map("x", "n", "'Nn'[v:searchforward]", { desc = "Next Search Result", expr = true })
map("o", "n", "'Nn'[v:searchforward]", { desc = "Next Search Result", expr = true })
map("n", "N", "'nN'[v:searchforward].'zv'", { desc = "Prev Search Result", expr = true })
map("x", "N", "'nN'[v:searchforward]", { desc = "Prev Search Result", expr = true })
map("o", "N", "'nN'[v:searchforward]", { desc = "Prev Search Result", expr = true })

map("i", ",", ",<c-g>u", { desc = "Add undo break-points" })
map("i", ".", ".<c-g>u", { desc = "Add undo break-points" })
map("i", ";", ";<c-g>u", { desc = "Add undo break-points" })

map("v", "<", "<gv", { desc = "Better indenting" })
map("v", ">", ">gv", { desc = "Better indenting" })

map("n", "<c-/>", function()
  require("customs.terminal").toggle()
end, { desc = "Toggle Terminal" })
map("t", "<c-/>", "<cmd>close<cr>", { desc = "Close Terminal" })
map("t", "<c-,>", "<c-\\><c-n>", { desc = "Exit Terminal Mode" })

map("n", "<c-b>", "<cmd>Task run<cr>", { desc = "Task Run" })
map("n", "<leader>cb", "<cmd>Task build<cr>", { desc = "Task Build" })
map("n", "<leader>fs", "<cmd>Task<cr>", { desc = "Task Manager" })
