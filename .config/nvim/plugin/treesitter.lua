local languages = {
  "lua",
  "markdown",
  "markdown_inline",
  "c",
  "cpp",
  "python",
}

local isnt_installed = function(lang)
  return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
end

local to_install = vim.tbl_filter(isnt_installed, languages)
if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end

local filetypes = {}
for _, lang in ipairs(languages) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
    table.insert(filetypes, ft)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function(ev)
    vim.treesitter.start(ev.buf)
  end,
})
