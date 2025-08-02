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
    callback = function(e)
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = e.buf })
      end

      map("n", "gd", vim.lsp.buf.definition)
      map("n", "gD", vim.lsp.buf.declaration)
      map("n", "K", function()
        vim.lsp.buf.hover({
          close_events = {
            "CursorMoved",
            "WinEnter",
            "ModeChanged",
          },
        })
      end)
      map("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end)
      map("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end)
      map("n", "<leader>xx", vim.diagnostic.setqflist)
    end,
  })
end)
