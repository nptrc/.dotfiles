local plugins = {}

for _, plugin in pairs({
  { "rcarriga/nvim-notify" },
  { "nvimdev/dashboard-nvim" },
  { "echasnovski/mini.pairs" },
  { "echasnovski/mini.ai" },
  { "folke/tokyonight.nvim" },
  { "MagicDuck/grug-far.nvim" },
  { "folke/trouble.nvim" },
  { "folke/todo-comments.nvim" },
  { "mfussenegger/nvim-lint" },
}) do
  table.insert(plugins, vim.tbl_extend("force", plugin, { enabled = false }))
end

return plugins
