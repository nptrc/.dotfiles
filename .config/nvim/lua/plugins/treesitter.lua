local parsers = {
  "lua",
  "luadoc",
  "vim",
  "vimdoc",
  "markdown",
  "markdown_inline",
  "bash",
  "asm",
  "nasm",
  "c",
  "cpp",
  "cmake",
  "ninja",
  "python",
  "json",
  "jsonc",
  "json5",
}

require("nvim-treesitter").install(parsers)
require("nvim-treesitter").update()

local parsersInstalled = require("nvim-treesitter.config").get_installed("parsers")
for _, parser in pairs(parsersInstalled) do
  local filetypes = vim.treesitter.language.get_filetypes(parser)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = filetypes,
    callback = function(args)
      vim.treesitter.start()
      vim.bo[args.buf].syntax = "on"
    end,
  })
end
