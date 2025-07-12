local augroup = function(name)
  vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("unlisted_buffer"),
  pattern = { "cmake_tools_terminal" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})
