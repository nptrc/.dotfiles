return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      underline = false,
      virtual_text = false,
    },
    inlay_hints = { enabled = false },
    servers = {
      clangd = {
        enabled = vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 0,
      },
      ccls = {
        enabled = vim.fn.filereadable(vim.uv.cwd() .. "/.ccls") == 1,
        init_options = {
          diagnostics = {
            onChange = 100,
          },
        },
      },
    },
  },
}
