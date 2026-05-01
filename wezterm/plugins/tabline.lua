local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
	options = {
		theme = "OneHalfDark",
		theme_overrides = {
			normal_mode = {
				b = { bg = "rgba(0,0,0,0)" },
				c = { bg = "rgba(0,0,0,0)" },
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

local function apply_tabline(config)
	tabline.apply_to_config(config)
end

return apply_tabline
