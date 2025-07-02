local H = require("builtins.helpers")
local function loadPlugin()
  local builtins_dir = vim.fn.stdpath("config") .. "/lua/builtins/"
  for _, plug in ipairs(vim.fn.readdir(builtins_dir)) do
    local path = builtins_dir .. plug
    if vim.fn.isdirectory(path) == 1 and H.file_exists("init.lua", path) then
      local module_name = "builtins." .. plug
      package.loaded[module_name] = nil
      require(module_name)
    end
  end
end

loadPlugin()
vim.api.nvim_create_user_command("ReloadPlugin", function()
  loadPlugin()
  H.notify("Reloaded all builtin plugins")
end, { nargs = 0 })
