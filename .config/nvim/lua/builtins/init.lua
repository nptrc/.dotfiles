local function loadPlugin()
  local builtins_dir = vim.fn.stdpath("config") .. "/lua/builtins/"
  for _, plug in ipairs(vim.fn.readdir(builtins_dir)) do
    local path = builtins_dir .. plug
    if vim.fn.isdirectory(path) == 1 and vim.fn.filereadable(path .. "/init.lua") == 1 then
      local module_name = "builtins." .. plug
      package.loaded[module_name] = nil
      require(module_name)
    end
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = loadPlugin,
})

vim.api.nvim_create_user_command("ReloadPlugin", function()
  loadPlugin()
end, { nargs = 0 })
