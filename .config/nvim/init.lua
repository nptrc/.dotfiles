require("config.lazy")

_G.dd = function(...)
  Snacks.debug.inspect(...)
end
vim.print = _G.dd

if vim.g.neovide then
  vim.opt.guifont = "FiraCode Nerd Font:h14"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true

  vim.keymap.set("n", "<c-s-v>", "p")
  vim.keymap.set("n", "<f11>", function()
    if vim.g.neovide_fullscreen == true then
      vim.g.neovide_fullscreen = false
    else
      vim.g.neovide_fullscreen = true
    end
  end)
end
