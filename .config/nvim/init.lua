vim.g.mapleader = " "

require("options")
require("autocmds")

local pack_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(pack_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    pack_path,
  })
  vim.cmd("packadd mini.nvim | helptags ALL")
end

local deps = require("mini.deps")
deps.setup()

_G.add = deps.add
_G.now = deps.now
_G.later = deps.later
_G.now_cond = vim.fn.argc(-1) > 0 and now or later

later(function()
  require("keymaps")
end)

now(function()
  add({ source = "catppuccin/nvim", name = "catppuccin" })
  vim.cmd.colorscheme("catppuccin")
end)
