vim.lsp.enable({
  "lua_ls",
  "pyright",
  "neocmake",
})

if vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 0 then
  vim.lsp.enable("clangd")
else
  vim.lsp.enable("ccls")
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.diagnostics = {
      underline = false,
    }

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
