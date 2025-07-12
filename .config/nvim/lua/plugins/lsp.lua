local function clangd_cmd()
  local clangd_opts = { "clangd" }

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
          latest_clangd = esp_clang .. name .. "/esp-clang/bin/clangd"
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
    diagnostics = {
      underline = false,
      virtual_text = false,
    },
    inlay_hints = { enabled = false },
    servers = {
      clangd = {
        cmd = clangd_cmd(),
        root_dir = {
          ".git",
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "Makefile",
          "CMakeLists.txt",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja",
          "compile_commands.json",
          "compile_flags.txt",
        },
      },
    },
  },
}
