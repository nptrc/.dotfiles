local H = {}

H.file_exists = function(pattern, base_dir)
  local path = (base_dir or vim.fn.getcwd()) .. "/" .. pattern
  local matches = vim.fn.glob(path, false, true)
  return #matches > 0
end

H.notify = function(msg, level)
  vim.notify(msg, level)
end

return H
