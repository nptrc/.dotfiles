local clangd_cmd = (function()
  local clangd_cmd_opts = { "clangd" }

  if vim.env.IDF_PATH then
    local base = vim.env.HOME .. "/.espressif/tools/esp-clang"
    local scandir = vim.uv.fs_scandir(base)
    if not scandir then
      return nil
    end

    local latest
    while true do
      local name = vim.uv.fs_scandir_next(scandir)
      if not name then
        break
      end
      if name:match("^esp%-.+") then
        latest = base .. "/" .. name .. "/esp-clang/bin/clangd"
      end
    end
    clangd_cmd_opts = {
      latest,
    }
  end

  return vim.list_extend(clangd_cmd_opts, {
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  })
end)()

return {
  cmd = clangd_cmd,
  filetypes = { "c", "cpp" },
}
