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
		active_tab = {
			fg_color = "#000000",
			bg_color = "#56b6c2",
		},
		inactive_tab = {
			fg_color = "#FFFFFF",
			bg_color = "rgba(0,0,0,0)",
		},
		new_tab = {
			fg_color = "rgba(0,0,0,1)",
			bg_color = "rgba(0,0,0,0)",
			intensity = "Half",
		},
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

-- TABS. some of these are overridden by tabline plugin
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.switch_to_last_active_tab_when_closing_tab = true

-- STATUSLINE
wezterm.on("update-right-status", function(window, pane)
	window:set_left_status(" Workspace: " .. window:active_workspace() .. "  ")
	window:set_right_status(
		"Domain: "
			.. pane:get_domain_name()
			.. " | "
			.. wezterm.nerdfonts.fa_clock_o
			.. "  "
			.. wezterm.strftime("%H:%M")
			.. " "
	)
end)

-- DOMAINS
config.unix_domains = {
	{
		name = "unix",
	},
}
-- config.default_gui_startup_args = { "connect", "unix" }

-- KEYS
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = require("keys")

-- RESURRECT
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save({
	interval_seconds = 300,
	save_tabs = true,
	save_windows = true,
	save_workspaces = true,
})
resurrect.set_max_nlines(5000)

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
-- local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
-- tabline.setup({
-- 	options = {
-- 		theme = "OneHalfDark",
-- 	},
-- 	sections = {
-- 		tabline_a = {},
-- 		tab_active = {
-- 			"index",
-- 			"process",
-- 		},
-- 	},
-- })
-- tabline.apply_to_config(config)

-- BAR
-- local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
-- bar.apply_to_config(config, {
-- 	padding = {
-- 		left = 1,
-- 		right = 1,
-- 	},
-- 	separator = {
-- 		space = 1,
-- 	},
-- 	modules = {
-- 		pane = {
-- 			enabled = false,
-- 		},
-- 		username = {
-- 			enabled = false,
-- 		},
-- 		hostname = {
-- 			enabled = false,
-- 		},
-- 		cwd = {
-- 			enabled = false,
-- 		},
-- 		clock = {
-- 			icon = false,
-- 		},
-- 	},
-- })

return config
