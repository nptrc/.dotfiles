return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      underline = false,
      virtual_text = false,
    },
    inlay_hints = { enabled = false },
    servers = {
      clangd = { enabled = false },
      ccls = {
        init_options = {
          diagnostics = {
            onChange = 100,
          },
        },
      },
    },
  },
}
