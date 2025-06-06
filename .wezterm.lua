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
	foreground = "#fff1e6",
	background = "#100e09",

	-- ANSI colors (normal)
	ansi = {
		"#232627", -- color0
		"#c81b1b", -- color1
		"#1bc81b", -- color2
		"#c8741b", -- color3
		"#1b1bc8", -- color4
		"#c81bc8", -- color5
		"#1bc8c8", -- color6
		"#c8c8c8", -- color7
	},

	-- Bright ANSI colors
	brights = {
		"#686868", -- color0 intense
		"#ff5454", -- color1 intense
		"#54ff54", -- color2 intense
		"#ffff54", -- color3 intense
		"#5454ff", -- color4 intense
		"#ff54ff", -- color5 intense
		"#54ffff", -- color6 intense
		"#ffffff", -- color7 intense
	},

	-- Other UI colors (optional)
	cursor_bg = "#fff1e6",
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
