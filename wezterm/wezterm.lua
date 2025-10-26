local keys = require("keys")

local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

if not is_windows then
	config.enable_wayland = false
end

config.max_fps = 144

config.window_close_confirmation = "NeverPrompt"
-- config.quit_when_all_windows_are_closed = false

if is_windows then
	config.default_prog = { "pwsh", "-NoLogo" }
end

-- COLORS
config.color_scheme = "OneHalfDark"

if is_windows then
	config.colors = {
		tab_bar = {
			background = "rgba(0,0,0,0)",
		},
		background = "#1e1f2a",
	}
	config.foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.2,
	}
	config.window_decorations = "RESIZE"
end

-- FONT
if is_windows then
	config.font = wezterm.font("JetBrains Mono Regular", { weight = "Regular" })
else
	config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
end
config.font_size = 12.0

-- PADDING
local default_padding = {
	left = 12,
	right = 12,
	top = 12,
	bottom = 12,
}
config.window_padding = default_padding

-- local default_window_frame = {
-- 	border_left_width = "0.5cell",
-- 	border_right_width = "0.5cell",
-- 	border_top_height = "0.25cell",
-- 	border_bottom_height = "0.25cell",
-- 	border_left_color = "blue",
-- 	border_right_color = "blue",
-- 	border_top_color = "blue",
-- 	border_bottom_color = "blue",
-- }
--
-- wezterm.on("update-status", function(window, _)
-- 	local tab = window:active_tab()
-- 	local panes = tab:panes()
-- 	local alt_screen_active = false
--
-- 	for i = 1, #panes, 1 do
-- 		local pane = panes[i]
-- 		if pane:is_alt_screen_active() then
-- 			alt_screen_active = true
-- 			break
-- 		end
-- 	end
--
-- 	if alt_screen_active then
-- 		window:set_config_overrides({
-- 			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
-- 			window_frame = {
-- 				border_left_width = "0cell",
-- 				border_right_width = "0cell",
-- 				border_top_height = "0cell",
-- 				border_bottom_height = "0cell",
-- 				border_left_color = "transparent",
-- 				border_right_color = "transparent",
-- 				border_top_color = "transparent",
-- 				border_bottom_color = "transparent",
-- 			},
-- 		})
-- 	else
-- 		window:set_config_overrides({
-- 			window_padding = default_padding,
-- 			window_frame = default_window_frame,
-- 		})
-- 	end
-- end)

-- 0 padding in neovim or other alt screens
-- doesn't work with domains :(
-- wezterm.on("update-status", function(window, _)
-- 	local tab = window:active_tab()
-- 	local panes = tab:panes()
-- 	local alt_screen_active = false
--
-- 	for i = 1, #panes, 1 do
-- 		local pane = panes[i]
-- 		if pane:is_alt_screen_active() then
-- 			alt_screen_active = true
-- 			break
-- 		end
-- 	end
--
-- 	if alt_screen_active then
-- 		window:set_config_overrides({
-- 			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
-- 		})
-- 	else
-- 		window:set_config_overrides({
-- 			window_padding = default_padding,
-- 		})
-- 	end
-- end)

-- BACKGROUND
-- config.win32_system_backdrop = "Acrylic"
-- config.window_background_opacity = 1
-- config.text_background_opacity = 1
config.window_background_opacity = 1
config.text_background_opacity = 1

-- TABS. some of these are important for tabline plugin
-- See: https://github.com/michaelbrusegard/tabline.wez/discussions/3
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.switch_to_last_active_tab_when_closing_tab = true
config.status_update_interval = 500

-- DOMAINS
config.unix_domains = {
	{
		name = "sessions",
	},
}
config.default_gui_startup_args = { "connect", "sessions" }

-- KEYS
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = keys

-- RESURRECT
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.state_manager.periodic_save({
	interval_seconds = 60 * 15, -- every 15 minutes
	save_tabs = true,
	save_windows = true,
	save_workspaces = true,
})
resurrect.state_manager.set_max_nlines(5000)

wezterm.on("es-workspace-switched-with-hotkey", function(window, _)
	local label = window:active_workspace()

	resurrect.workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
		window = window:mux_window(),
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
		close_open_tabs = true,
		close_open_panes = true,
	})
end)

-- fix tab names not resurrecting properly
-- NOTE: hold up. cli fix for renaming tabs doesn't even work
--
-- wezterm.on("resurrect.tab_state.restore_tab.finished", function()
-- 	local window = wezterm.gui.gui_windows()[1]
-- 	local tab_id = window:active_tab():tab_id() - 1
-- 	wezterm.log_info("Tab id:")
-- 	wezterm.log_info(tab_id)
--
-- 	-- now I need workspace_id
--
-- 	local state = resurrect.state_manager.load_state(id, "workspace")
-- 	wezterm.log_info("Workspace state:")
-- 	wezterm.log_info(workspace_state)
--
-- 	-- what im missing: tab title from resurrect, pane
--
-- 	-- window:perform_action(
-- 	-- 	wezterm.action.SpawnCommandInNewTab({
-- 	-- 		args = {
-- 	-- 			"wezterm",
-- 	-- 			"cli",
-- 	-- 			"set-tab-title",
-- 	-- 			"--tab-id",
-- 	-- 			tostring(tab_id),
-- 	-- 			line,
-- 	-- 		},
-- 	-- 	}),
-- 	-- 	pane
-- 	-- )
-- end)

require("smart_workspace_switcher")

-- TABLINE
-- Kan ta i bruk hvis den støtte renaming av tabs
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		theme = "OneHalfDark",
		theme_overrides = {
			normal_mode = {
				b = { bg = "rgba(0,0,0,0)" },
				y = { bg = "rgba(0,0,0,0)" },
			},
			tab = {
				active = { fg = "#ffffff", bg = "rgba(0,0,0,0)" },
				inactive = { fg = "#61afef", bg = "rgba(0,0,0,0)" },
				inactive_hover = { bg = "rgba(0,0,0,0)" },
			},
		},
		section_separators = "",
		component_separators = "",
		tab_separators = "",
	},
	sections = {
		tabline_a = {},
		tabline_c = {},
		tab_active = {
			{ "index", padding = { left = 1, right = 0 } },
			{ "tab", icons_enabled = false },
		},
		tab_inactive = {
			{ "index", padding = { left = 1, right = 0 } },
			{ "tab", icons_enabled = false },
		},
		tabline_x = {},
		tabline_y = { "battery", { "datetime", padding = 1 } },
	},
	extensions = { "resurrect", "smart_workspace_switcher" },
})
tabline.apply_to_config(config)

-- SMART SPLITS
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	-- use keys "move" and "resize" to use seprate direction keys for move vs resize
	direction_keys = { "h", "j", "k", "l" },
	modifiers = {
		move = "CTRL",
		resize = "CTRL|SHIFT|ALT",
	},
})

return config
