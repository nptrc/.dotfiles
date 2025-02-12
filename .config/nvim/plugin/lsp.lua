local server_conf_path = vim.api.nvim_get_runtime_file("lsp/*.lua", true)

for _, server in pairs(server_conf_path) do
  vim.lsp.enable(vim.fn.fnamemodify(server, ":t:r"))
end

vim.lsp.config("*", {
  root_markers = { ".git" },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },
})

vim.diagnostic.config({
  underline = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  -- stylua: ignore
  callback = function()
    local map = vim.keymap.set

    map("n", "gd", function() Snacks.picker.lsp_definitions() end)
    map("n", "gD", function() Snacks.picker.lsp_declarations() end)
    map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true })
    map("n", "<leader>sd", function() Snacks.picker.diagnostics() end)
    map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end)
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
  end,
})
