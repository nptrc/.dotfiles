local function setup_clangd_cmd()
  local clangd_opts = { vim.fn.stdpath("data") .. "/mason/bin/clangd" }

  if os.getenv("IDF_PATH") then
    local home = vim.env.HOME
    local esp_clang = home .. "/.espressif/tools/esp-clang/"
    local scandir = vim.uv.fs_scandir(esp_clang)
    if scandir then
      local latest_clangd
      while true do
        local name = vim.uv.fs_scandir_next(scandir)
        if not name then
          break
        end
        if name:match("^esp%-.+") then
          latest_clangd = esp_clang .. "/" .. name .. "/esp-clang/bin/clangd"
        end
      end
      clangd_opts = { latest_clangd, "--query-driver=**" }
    end
  end

  return vim.tbl_extend("keep", clangd_opts, {
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  })
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },

    servers = {
      clangd = {
        cmd = setup_clangd_cmd(),
      },
      html = {},
      cssls = {},
    },
  },
}
