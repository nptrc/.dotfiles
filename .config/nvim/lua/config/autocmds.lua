-- insert mode in term buffer
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":startinsert")
    end
  end,
})

-- disable kitty padding
vim.api.nvim_create_autocmd({ "VimEnter", "BufRead" }, {
  command = ":silent !kitty @ set-spacing padding-left=0 padding-top=0",
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding-left=default padding-top=default",
})
