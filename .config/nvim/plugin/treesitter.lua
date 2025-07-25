now_cond(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })

  add({
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    checkout = "main",
  })

  local ensure_installed = {
    "bash",
    "json",
    "json5",
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
  local ts_start = function(e)
    vim.treesitter.start(e.buf)
  end
  vim.api.nvim_create_autocmd("FileType", { pattern = filetypes, callback = ts_start })
end)
