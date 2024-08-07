-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.audible_bell = "Disabled"

config.font =
	wezterm.font('JetbrainsMonoNL Nerd Font')
config.color_scheme = "GruvboxDarkHard"
-- config.color_schemes = {
-- 	["GruvboxDarkHard"] = {
-- 		background = "#1b1b1c",
-- 	},
-- }


config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"
config.font_size = 18

config.automatically_reload_config = true
config.check_for_updates = true

config.pane_focus_follows_mouse = true
-- config.window_background_opacity = 0.95

return config
