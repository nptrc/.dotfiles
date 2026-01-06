vim.lsp.enable({
  "lua_ls",
  "pyright",
})

if vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 0 then
  vim.lsp.enable("clangd")
else
  vim.lsp.enable("ccls")
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.diagnostic.config({
      underline = false,
    })
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
  end,
})
