-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "tokyonight_moon"

config.default_cursor_style = "BlinkingBlock"
config.automatically_reload_config = true

-- fonts
config.font_size = 12
-- config.dpi = 144.0
config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.font_rules = {
	{
		intensity = "Normal",
		italic = false,
		font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Regular", style = "Normal" }),
	},
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

-- my coolnight colorscheme:
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#c83232", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#c83232", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

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
-- config.window_background_opacity = 0.8
-- config.macos_window_background_blur = 50

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
		-- Before
		--regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
		--format = '$0',
		-- After
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
	top = 0,
	bottom = 0,
}

-- background
config.background = {
	{
		source = {
			File = {
				path = "/Users/"
					.. os.getenv("USER")
					-- .. "/.config/wezterm/ingmar-h-HZksGaLPJA4-unsplash.jpg",
					.. "/.config/wezterm/archieprofile.jpg",
			},
		},
		hsb = {
			hue = .5,
			saturation = 1.0,
			brightness = 0.05,
		},
		vertical_align = "Middle", -- Top, Middle, Bottom
		horizontal_align = "Center", -- Left, Center, Right
	},
	{
		source = {
			Color = "#1A1717",
		},
		width = "100%",
		height = "100%",
		opacity = .5,
	},
}

-- and finally, return the configuration to wezterm
return config
