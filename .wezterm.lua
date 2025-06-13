local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local CONFIG = {
	-- Remove title bar and window frame
	window_decorations = "NONE",

	enable_tab_bar = true, -- Keep WezTerm's own tab bar
	hide_tab_bar_if_only_one_tab = true,

	-- Optional: Add padding since there's no window chrome
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},

	-- Semi-transparent black background
	window_background_opacity = 0.80,
	text_background_opacity = 1.0,

	default_cursor_style = "BlinkingBar",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 600, -- Milliseconds

	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.5,
	},
	bold_brightens_ansi_colors = true,

	-- Force the cursor to be a thin vertical line
	force_reverse_video_cursor = true,
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font({ family = "Fira Code Nerd Font", weight = "Bold" }),
		},
	},

	font = wezterm.font_with_fallback({
		{ family = "Fira Code Nerd Font", weight = "Regular" },
		"Consolas",
	}),
	font_size = 11.0,

	-- Persist tabs when the window is closed
	window_close_confirmation = "NeverPrompt",
	-- Automatically restore tabs when reopening
	default_gui_startup_args = { "connect", "wezterm" },
}

CONFIG.colors = {
	-- Default colors
	foreground = "#F3EAD2",
	background = "#100e09",

	-- ANSI colors (normal)
	ansi = {
		"#0C0C0C", -- color0
		"#C50F1F", -- color1
		"#13A10E", -- color2
		"#C19C00", -- color3
		"#0037DA", -- color4
		"#881798", -- color5
		"#3A96DD", -- color6
		"#CCCCCC", -- color7
	},

	-- Bright ANSI colors
	brights = {
		"#767676", -- color0 intense
		"#E74856", -- color1 intense
		"#16C60C", -- color2 intense
		"#F9F1A5", -- color3 intense
		"#3B78FF", -- color4 intense
		"#B4009E", -- color5 intense
		"#61D6D6", -- color6 intense
		"#F2F2F2", -- color7 intense
	},

	-- Other UI colors (optional)
	cursor_bg = "#F3EAD2",
}

CONFIG.keys = {
	-- Tabs
	{ key = "LeftArrow", mods = "SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SHIFT", action = wezterm.action.ActivateTabRelative(1) },

	-- Splits
	{ key = "(", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = ")", mods = "CTRL", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Pane navigation (arrows)
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
}

return CONFIG
