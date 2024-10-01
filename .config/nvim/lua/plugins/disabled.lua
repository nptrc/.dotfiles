local plugins = {}

for _, plugin in pairs({
  { "rcarriga/nvim-notify" },
  { "nvimdev/dashboard-nvim" },
  { "echasnovski/mini.pairs" },
  { "folke/tokyonight.nvim" },
}) do
  table.insert(plugins, vim.tbl_extend("force", plugin, { enabled = false }))
end

return plugins
