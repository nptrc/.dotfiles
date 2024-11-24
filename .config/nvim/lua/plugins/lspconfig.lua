return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- load defaults i.e lua_lsp
      require("nvchad.configs.lspconfig").defaults()

      local nvlsp = require "nvchad.configs.lspconfig"
      local servers = {
        clangd = {},
        cmake = {},
        pyright = {},
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              validate = { enable = true },
            },
          },
        },
        marksman = {},
      }

      -- lsps with default config
      for name, opts in pairs(servers) do
        opts.on_init = nvlsp.on_init
        opts.on_attach = nvlsp.on_attach
        opts.capabilities = nvlsp.capabilities

        require("lspconfig")[name].setup(opts)
      end
    end,
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
}
