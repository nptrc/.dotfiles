local plugins = {}

for _, plugin in pairs({
  { "catppuccin/nvim" },
  { "echasnovski/mini.pairs" },
  { "MagicDuck/grug-far.nvim" },
  { "mfussenegger/nvim-lint" },
}) do
  table.insert(plugins, vim.tbl_extend("force", plugin, { enabled = false }))
end

return plugins
