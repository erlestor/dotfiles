local keys = require("keys")

local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

-- load plugins
require("plugins/resurrect") -- Remember tabs and panes when opening workspace
require("plugins/smart_workspace_switcher") -- Use CTRL + F to open a directory in a new workspace
local apply_tabline = require("plugins/tabline") -- Nice tab bar
apply_tabline(config)
local apply_smart_splits = require("plugins/smart_splits") -- Nice tab bar
apply_smart_splits(config)

if not is_windows then
	config.enable_wayland = false
end

config.max_fps = 144

config.window_close_confirmation = "NeverPrompt"

if is_windows then
	config.default_prog = { "pwsh", "-NoLogo" }
end

-- COLORS
config.color_scheme = "OneHalfDark"

config.colors = {
	tab_bar = {
		background = "rgba(0,0,0,0)",
	},
	background = "#1e1f2a",
}
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.0,
	brightness = 1.1,
}
if is_windows then
	config.window_decorations = "RESIZE"
end

-- FONT
if is_windows then
	config.font = wezterm.font("JetBrains Mono Regular", { weight = "Regular" })
else
	config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
end
config.font_size = 12.0

-- BACKGROUND
-- config.win32_system_backdrop = "Acrylic"
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

-- PADDING
config.window_padding = { left = 0, right = 0, top = 12, bottom = 12 }

-- this is complete madness wtf. Im doing all this just so I can have a bit of padding around my prompt in bash

-- config.status_update_interval = 500 -- ms, i was fucking around with this for faster padding switching
--
-- config.window_padding = { left = 12, right = 12, top = 12, bottom = 12 }
--
-- wezterm.on("user-var-changed", function(window, pane, name, value)
-- 	if name == "NVIM" then
-- 		local overrides = window:get_config_overrides() or {}
-- 		if value == "1" then
-- 			overrides.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
-- 		else
-- 			overrides.window_padding = { left = 12, right = 12, top = 12, bottom = 12 }
-- 		end
-- 		window:set_config_overrides(overrides)
-- 	end
-- end)
--
-- local function get_padding(is_nvim)
-- 	if is_nvim then
-- 		return { left = 0, right = 0, top = 0, bottom = 0 }
-- 	else
-- 		return { left = 12, right = 12, top = 12, bottom = 12 }
-- 	end
-- end
--
-- local function apply_padding_for_tab(window, target_tab)
-- 	if not target_tab then
-- 		return
-- 	end
-- 	local vars = target_tab:active_pane():get_user_vars()
-- 	local overrides = window:get_config_overrides() or {}
-- 	overrides.window_padding = get_padding(vars.NVIM == "1")
-- 	window:set_config_overrides(overrides)
-- end
--
-- -- Absolute tab switching (Ctrl+1 through Ctrl+9)
-- for i = 1, 9 do
-- 	table.insert(config.keys, {
-- 		key = tostring(i),
-- 		mods = "LEADER",
-- 		action = wezterm.action_callback(function(window, pane)
-- 			local tabs = window:mux_window():tabs()
-- 			apply_padding_for_tab(window, tabs[i])
-- 			window:perform_action(wezterm.action.ActivateTab(i - 1), pane)
-- 		end),
-- 	})
-- end
-- -- Relative tab switching
-- local function relative_tab_action(delta)
-- 	return wezterm.action_callback(function(window, pane)
-- 		local tabs = window:mux_window():tabs()
-- 		local current = window:active_tab():tab_id()
-- 		local current_index = 1
-- 		for i, tab in ipairs(tabs) do
-- 			if tab:tab_id() == current then
-- 				current_index = i
-- 				break
-- 			end
-- 		end
-- 		-- Wrapping arithmetic
-- 		local target_index = ((current_index - 1 + delta) % #tabs) + 1
-- 		apply_padding_for_tab(window, tabs[target_index])
-- 		window:perform_action(wezterm.action.ActivateTabRelative(delta), pane)
-- 	end)
-- end
--
-- table.insert(config.keys, {
-- 	key = "p", -- whatever your prev-tab key is
-- 	mods = "LEADER",
-- 	action = relative_tab_action(-1),
-- })
--
-- table.insert(config.keys, {
-- 	key = "n", -- whatever your next-tab key is
-- 	mods = "LEADER",
-- 	action = relative_tab_action(1),
-- })

return config
