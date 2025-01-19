local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

config.default_prog = { "/bin/bash" }

config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14

config.keys = {
	{ key = "[", mods = "CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = act.ScrollByLine(-3),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = act.ScrollByLine(3),
	},
}

config.window_frame = {
	font = wezterm.font({ family = "FiraCode Nerd Font" }),
	font_size = 12.0,
}

config.max_fps = 144
config.audible_bell = "Disabled"
config.check_for_updates = false
config.scrollback_lines = 99999

config.initial_rows = 28
config.initial_cols = 100

config.cursor_thickness = 2

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false

return config
