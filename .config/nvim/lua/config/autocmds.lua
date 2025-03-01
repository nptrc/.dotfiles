local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("disable_number_in_terminal"),
  command = "setlocal nonumber norelativenumber",
})

vim.api.nvim_create_autocmd({ "VimEnter", "BufRead" }, {
  group = augroup("disable_kitty_padding"),
  command = ":silent !kitty @ set-spacing padding-left=0 padding-top=0",
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = augroup("enable_kitty_padding"),
  command = ":silent !kitty @ set-spacing padding-left=default padding-top=default",
})
