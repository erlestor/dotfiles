local wezterm = require("wezterm") -- local act = wezterm.action
-- local mux = wezterm.mux
local config = wezterm.config_builder()

config.front_end = "OpenGL"
-- WebGpu is supposedly faster, but doesnt work with transparent background
-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[1]
-- config.front_end = "WebGpu"
config.max_fps = 144
config.default_prog = { "pwsh", "-NoLogo" }
config.window_close_confirmation = "NeverPrompt"
config.quit_when_all_windows_are_closed = false

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
	brightness = 1.2,
}
config.window_decorations = "RESIZE"

-- FONT
config.font = wezterm.font("JetBrains Mono Regular", { weight = "Regular" })
config.font_size = 12.0

-- PADDING
local default_padding = {
	left = 12,
	right = 12,
	top = 12,
	bottom = 12,
}
config.window_padding = default_padding
-- 0 padding in neovim or other alt screens
wezterm.on("update-status", function(window, _)
	local tab = window:active_tab()
	local panes = tab:panes()
	local alt_screen_active = false

	for i = 1, #panes, 1 do
		local pane = panes[i]
		if pane:is_alt_screen_active() then
			alt_screen_active = true
			break
		end
	end

	if alt_screen_active then
		window:set_config_overrides({
			window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
		})
	else
		window:set_config_overrides({
			window_padding = default_padding,
		})
	end
end)

-- BACKGROUND
config.win32_system_backdrop = "Acrylic"
config.window_background_opacity = 0.7
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
-- config.unix_domains = {
-- 	{
-- 		name = "unix",
-- 	},
-- }
-- config.default_gui_startup_args = { "connect", "unix" }

-- KEYS
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = require("keys")

-- RESURRECT
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.state_manager.periodic_save({
	interval_seconds = 300,
	save_tabs = true,
	save_windows = true,
	save_workspaces = true,
})
resurrect.state_manager.set_max_nlines(5000)

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
				active = { bg = "rgba(0,0,0,0)" },
				inactive = { bg = "rgba(0,0,0,0)" },
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
			"tab",
		},
		tab_inactive = {
			{ "index", padding = { left = 1, right = 0 } },
			"tab",
		},
		tabline_x = {},
		tabline_y = { "battery", { "datetime", padding = 2 } },
	},
	extensions = { "resurrect" },
})

return config
