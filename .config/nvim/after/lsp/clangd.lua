local clangd_cmd = (function()
  local clangd_bin = "clangd"

  if vim.env.IDF_PATH then
    local base = vim.env.HOME .. "/.espressif/tools/esp-clang"
    local scandir = vim.uv.fs_scandir(base)

    if scandir then
      local versions = {}
      while true do
        local name, type = vim.uv.fs_scandir_next(scandir)
        if not name then break end

        if name:match("^esp%-.+") and type == "directory" then
          table.insert(versions, name)
        end
      end

      table.sort(versions)

      if #versions > 0 then
        local target_bin = base .. "/" .. versions[#versions] .. "/esp-clang/bin/clangd"
        if vim.uv.fs_access(target_bin, "X") then
          clangd_bin = target_bin
        end
      end
    end
  end

  return {
    clangd_bin,
    "--query-driver=**/*gcc,**/*g++,**/*clang,**/*clang++",
    "--background-index",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--function-arg-placeholders=1",
  }
end)()

return {
  cmd = clangd_cmd,
  filetypes = { "c", "cpp" },
}
