local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("update-right-status", function(window, _)
	window:set_right_status(window:active_workspace())
end)

wezterm.on("augment-command-palette", function(_, _)
	return {
		{
			brief = "Configure Workspace for Development Environment",
			action = wezterm.action_callback(function(window, _, _)
				local parent = window:mux_window()

				parent:active_tab():set_title("🤖")

				local tab_edit, _, _ = parent:spawn_tab({ args = { "nvim" } })
				tab_edit:set_title("💻")

				local tab_scratch, _, _ = parent:spawn_tab({})
				tab_scratch:set_title("📝")

				tab_edit:activate()
			end),
		},
	}
end)

local config = {
	disable_default_key_bindings = true,
	scrollback_lines = 100000,
	keys = {
		{
			key = "a",
			mods = "CTRL",
			action = act.SendKey({ key = "a", mods = "CTRL" }),
		},
		{
			key = "P",
			mods = "CTRL",
			action = act.ActivateCommandPalette,
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
			key = "F",
			mods = "CTRL|SHIFT",
			action = act.Search({ CaseInSensitiveString = "" }),
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
			key = "K",
			mods = "CTRL|SHIFT",
			action = act.ClearScrollback("ScrollbackAndViewport"),
		},
		{
			key = "S",
			mods = "CTRL|SHIFT",
			action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{
			key = "W",
			mods = "CTRL|SHIFT",
			action = act.PromptInputLine({
				description = "Create Workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
					end
				end),
			}),
		},
		{
			key = "$",
			mods = "CTRL|SHIFT",
			action = act.PromptInputLine({
				description = "Rename Workspace",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						mux.rename_workspace(window:active_workspace(), line)
					end
				end),
			}),
		},
	},
	force_reverse_video_cursor = true,
	window_background_opacity = 0.99,
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
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = act.ActivateTab(i - 1),
	})
end

return config
