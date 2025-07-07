local M = {}

M.delete = function()
  local buf = vim.api.nvim_get_current_buf()

  if vim.bo.modified then
    local ok, choice = pcall(vim.fn.confirm, ("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if not ok or choice == 0 or choice == 3 then
      return
    end
    if choice == 1 then
      vim.cmd.write()
    end
  end

  local altbuf = vim.fn.bufnr("#")
  if altbuf ~= buf and vim.fn.buflisted(altbuf) == 1 then
    vim.api.nvim_set_current_buf(altbuf)
    vim.api.nvim_buf_delete(buf, { force = true })
    return
  end

  vim.cmd.bprevious()
  if buf ~= vim.api.nvim_get_current_buf() then
    vim.api.nvim_buf_delete(buf, { force = true })
    return
  end

  local newbuf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(newbuf)
  vim.api.nvim_buf_delete(buf, { force = true })
end

return M
