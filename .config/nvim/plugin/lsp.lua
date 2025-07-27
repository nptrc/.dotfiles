later(function()
  add("mason-org/mason.nvim")
  require("mason").setup()

  add("neovim/nvim-lspconfig")

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        callSnippet = "Replace",
        hint = {
          enable = true,
          paramName = "Disable",
          semicolon = "Disable",
          arrayIndex = "Disable",
        },
      },
    },
  })

  vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  })

  vim.lsp.config("ccls", {
    init_options = {
      diagnostics = {
        onChange = 100,
      },
    },
  })

  vim.lsp.enable({
    "lua_ls",
    "neocmake",
    "pyright",
  })

  if vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 0 then
    vim.lsp.enable("clangd")
  else
    vim.lsp.enable("ccls")
  end

  vim.diagnostic.config({
    underline = false,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
      local map = vim.keymap.set

      map("n", "cl", function()
        require("snacks").picker.lsp_config()
      end, { desc = "Lsp Info" })

      map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
      map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
      map("n", "gca", vim.lsp.buf.code_action, { desc = "Code Action" })
      map("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, { desc = "Next Diagnostic" })
      map("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, { desc = "Prev Diagnostic" })
      map("n", "<leader>xx", function()
        vim.diagnostic.setqflist()
      end, { desc = "QuickFix Diagnostic" })
    end,
  })
end)
