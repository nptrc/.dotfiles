local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = augroup("enable_kitty_padding"),
  command = ":silent !kitty @ set-spacing padding-left=default padding-top=default",
})

vim.api.nvim_create_autocmd({ "BufRead", "VimEnter" }, {
  group = augroup("disable_kitty_padding"),
  command = "silent !kitty @ set-spacing padding-left=0 padding-top=0",
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("unlisted_buffer"),
  pattern = { "cmake_tools_terminal" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})
