local wezterm = require("wezterm")

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local function apply_smart_splits(config)
	smart_splits.apply_to_config(config, {
		-- use keys "move" and "resize" to use seprate direction keys for move vs resize
		direction_keys = { "h", "j", "k", "l" },
		modifiers = {
			move = "CTRL",
			resize = "CTRL|SHIFT|ALT",
		},
	})
end

return apply_smart_splits
