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
  update_in_insert = true,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  -- stylua: ignore
  callback = function()
    vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end)
    vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end)
    vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true })
    vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end)
    vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
  end,
})
