-- ==== WAYWALL GENERIC CONFIG ====
local main = require("main")

local remaps = require("remaps")

local cfg = {
	debug_text = false,

	-- ==== LOOKS ====
	resolution = { 2560, 1440 },

	bg_col = "#000000",
	toggle_bg_picture = false,
	text_col = "#FFFFFF",
	pie_chart_1 = "#EC6E4E",
	pie_chart_2 = "#46CE66",
	pie_chart_3 = "#E446C4",

	ninbot_anchor = {
		position = "topright", -- topleft, top, topright, left, right, bottomleft, bottomright
		x = 0,
		-- y = 0,
		y = 130, -- default offset
	},
	ninbot_opacity = 1, -- 0 to 1

	-- ==== ALTERNATIVE RESOLUTIONS ====
	thin_res = { 400, 1440 },
	wide_res = { 2560, 400 },
	tall_res = { 384, 16384 },

	-- ==== MIRRORS ====
	e_count = { enabled = true, x = 1500, y = 400, size = 5, colorkey = false, show_c = false },

	thin_pie = { enabled = true, x = 1495, y = 645, size = 4, colorkey = false }, -- Turning off colorkeying also maintains the original pie chart's dimensions and shows the percentages
	tall_pie = { enabled = true, x = 1495, y = 645, size = 4, colorkey = false }, -- Leave same as thin for seamlessness

	thin_percent = { enabled = false, x = 1568, y = 1050, size = 6 },
	tall_percent = { enabled = false, x = 1568, y = 1050, size = 6 }, -- Leave same as thin for seamlessness
	percentages_match_text = false, -- Enabling this makes the percentages match the text color rather than the pie colors

	measuring_window = { x = 15, y = 340, size = 15 },
	stretched_measure = true,

	-- ==== MACROS ====
	-- resolution changes
	thin = { key = "*-LESS", f3_safe = false, ingame_only = true },
	wide = { key = "*-B", f3_safe = true, ingame_only = true },
	tall = { key = "*-BAR", f3_safe = false, ingame_only = false },

	-- startup actions
	toggle_fullscreen_key = "Shift-O",
	launch_paceman_key = "Shift-P",

	-- during game actions
	toggle_ninbot_key = "*-n",
	toggle_remaps_key = "Insert",

	-- ==== KEYBOARD ====
	xkb_config = { -- set any setting to nil if unwanted
		enabled = false,
		layout = "mc", -- ~/.config/xkb/symbols/mc
		rules = nil, -- ~/.config/xkb/rules/...
		variant = "basic",
		options = "caps:none",
	},
	remaps_text_config = { text = "chat mode", x = 100, y = 100, size = 2, color = "#000000" },

	-- ==== MISC ====
	sens_change = { enabled = true, normal = 4.39040021, tall = 0.29617377, raw_input = false }, -- setting raw_input to true will enable sens changing via maccel
	enable_resize_animations = false,
}

return main(cfg, remaps)
