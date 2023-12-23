local wezterm = require("wezterm")
local act = wezterm.action

return {
	disable_default_key_bindings = true,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{
			key = "-",
			mods = "LEADER",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "_",
			mods = "LEADER|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "R",
			mods = "CTRL|SHIFT",
			action = act.ReloadConfiguration,
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = act.CopyTo("Clipboard"),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = act.PasteFrom("Clipboard"),
		},
		{
			key = "X",
			mods = "CTRL|SHIFT",
			action = act.ActivateCopyMode,
		},
		{
			key = "Space",
			mods = "CTRL|SHIFT",
			action = act.QuickSelect,
		},
		{
			key = "F",
			mods = "CTRL|SHIFT",
			action = act.Search({ CaseInSensitiveString = "" }),
		},
		{
			key = "Z",
			mods = "CTRL|SHIFT",
			action = act.TogglePaneZoomState,
		},
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "Enter",
			mods = "ALT",
			action = act.ToggleFullScreen,
		},
		{
			key = "E",
			mods = "CTRL|SHIFT",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	},
	force_reverse_video_cursor = true,
	colors = {
		foreground = "#dcd7ba",
		background = "#1f1f28",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},
	wsl_domains = {
		{
			name = "WSL:Ubuntu-20.04",
			distribution = "Ubuntu-20.04",
			default_cwd = "~",
		},
	},
}
