local function setup_clangd_cmd()
  local esp_idf_path = os.getenv("IDF_PATH")
  local clangd_opts = { "clangd" }

  if esp_idf_path then
    clangd_opts = {
      "/home/nptrc/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd",
      "--query-driver=**",
    }
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
    },
  },
}
