-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"
config.colors = { cursor_bg = "#f4dbd6", cursor_border = "#f4dbd6" }

config.default_cursor_style = "BlinkingBlock"
config.automatically_reload_config = true

-- fonts
config.font_size = 14
config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.font_rules = {
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({ family = "VictorMono Nerd Font", weight = "Medium", style = "Italic" }),
	},
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Bold", style = "Normal" }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({ family = "CaskaydiaCove Nerd Font", weight = "Bold", style = "Italic" }),
	},
	{
		intensity = "Half",
		italic = false,
		font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Light", style = "Normal" }),
	},
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font({ family = "VictorMono Nerd Font", weight = "Light", style = "Italic" }),
	},
}

-- tabbar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- scrollbar
config.enable_scroll_bar = true

-- inactive pane dimming
config.inactive_pane_hsb = { saturation = 0.7, brightness = 0.6 }

-- keymapping
config.keys = {
	-- Shift + Ctrl + M for R pipe '%>%'
	{ key = "M", mods = "CTRL|SHIFT", action = wezterm.action.SendString(" %>% ") },
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action.SendString("\x1bb") },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendString("\x1bf") },
}

--windows
config.window_decorations = "RESIZE"

config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
		format = "$1",
		highlight = 1,
	},
	-- implicit mailto link
	{
		regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
		format = "mailto:$0",
	},
}

config.window_padding = {
	left = 3,
	right = 3,
	top = 5,
	bottom = 0,
}

-- background
config.background = {
	{
		source = {
			File = {
				path = wezterm.home_dir .. "/.config/wezterm/archieprofile.jpg",
			},
		},
		hsb = {
			hue = .5,
			saturation = 1.0,
			brightness = 0.02,
		},
		vertical_align = "Middle", -- Top, Middle, Bottom
		horizontal_align = "Center", -- Left, Center, Right
	},
	{
		source = {
			Color = "#24273A",
		},
		width = "100%",
		height = "100%",
		opacity = .6,
	},
}

-- and finally, return the configuration to wezterm
return config
