local ensure_installed = {
  "lua",
  "bash",
  "json",
  "json5",
  "c",
  "cpp",
  "ninja",
  "cmake",
  "python",
}

require("nvim-treesitter").install(ensure_installed)
local isnt_installed = function(lang)
  return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
end
local to_install = vim.tbl_filter(isnt_installed, ensure_installed)
if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end

local filetypes = vim.iter(ensure_installed):map(vim.treesitter.language.get_filetypes):flatten():totable()
vim.list_extend(filetypes, { "markdown" })
vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function(e)
    vim.treesitter.start(e.buf)
  end,
})
