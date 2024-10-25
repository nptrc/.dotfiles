require "nvchad.mappings"

local map = vim.keymap.set
local dmap = vim.keymap.del

-- back to normal mode
map("i", "jk", "<esc>")
map("t", "jk", "<C-\\><C-n>")

-- don't have to press shift anymore
map("n", ";", ":")

-- quit all
map("n", "<leader>qq", "<cmd>qa<cr>")

-- better up/down
map("n", "j", "gj")
map("n", "k", "gk")

-- split window
map("n", "ss", ":sp<Cr>")
map("n", "sv", ":vs<Cr>")

-- navigate window
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- resize window
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- move lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==")
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>")
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>")

-- buffers navigate
map("n", "<leader>bd", "<cmd>lua require('nvchad.tabufline').close_buffer()<cr>")
map("n", "<S-h>", "<cmd>lua require('nvchad.tabufline').prev()<cr>")
map("n", "<S-l>", "<cmd>lua require('nvchad.tabufline').next()<cr>")

-- file explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
dmap("n", "<C-n>")

-- code runner
map("n", "<C-b>", "<cmd>RunCode<cr>")
