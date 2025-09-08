vim.g.mapleader = " "

require("options")
require("autocmds")
require("keymaps")

require("vim._extui").enable({})
vim.cmd.colorscheme("me")

local gh = function(spec)
  return "https://github.com/" .. spec
end

vim.pack.add({
  gh("neovim/nvim-lspconfig"),
  gh("nvim-mini/mini.nvim"),
  gh("windwp/nvim-autopairs"),
  gh("stevearc/conform.nvim"),
  gh("folke/snacks.nvim"),
  { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
}, { confirm = false })

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function()
    vim.cmd("TSUpdate")
  end,
})

_G.now = function(cb)
  cb()
end
_G.later = function(cb)
  vim.schedule(cb)
end
_G.now_cond = vim.fn.argc(-1) > 0 and now or later
