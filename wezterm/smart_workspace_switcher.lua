local wezterm = require("wezterm")
local utils = require("utils")

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local colors = wezterm.color.get_builtin_schemes()["OneHalfDark"]

-- normalize a filesystem path: expand ~, remove ANSI/escape sequences, collapse resolved path
local function normalize_path(p)
	-- remove ANSI escape sequences
	p = p:gsub("\27%[[0-9;]*m", "")
	-- expand ~ to home
	if p:sub(1, 2) == "~/" then
		p = wezterm.home_dir .. p:sub(2)
	end
	-- for simplicity: remove trailing slash
	if #p > 1 and p:sub(-1) == "/" then
		p = p:sub(1, -2)
	end
	return p
end

-- remove duplicates from list of objects { id = ..., label = ... }
-- keep first object for each unique normalized id
local function unique_by_id(list)
	local seen = {}
	local result = {}
	for _, obj in ipairs(list) do
		if obj.id then
			local norm = normalize_path(obj.id)
			if not seen[norm] then
				seen[norm] = true
				table.insert(result, obj)
			else
				wezterm.log_info(obj.id)
			end
		else
			-- if no id field, just include it
			table.insert(result, obj)
		end
	end
	return result
end

workspace_switcher.get_choices = function(_)
	local choices = utils.array_concat(workspace_switcher.choices.get_workspace_elements({}), {
		{ id = "config", label = "config" },
	}, workspace_switcher.choices.get_zoxide_elements({}))

	local unique_choices = unique_by_id(choices)

	return unique_choices
end
--
workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = false } },
		{ Foreground = { Color = colors.ansi[3] } },
		{ Background = { Color = colors.background } },
		{ Text = "󱂬  " .. label },
	})
end

-- loads the state whenever I create a new workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, _, label)
	-- for some goddamn reason. resurrect can't spawn tabs in the window if we don't wait first
	wezterm.sleep_ms(100)

	resurrect.workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		resize_window = false,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
		close_open_tabs = true,
		close_open_panes = true,
	})
end)

-- Saves the state whenever I select a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(_, _, _)
	local workspace_state = resurrect.workspace_state
	resurrect.state_manager.save_state(workspace_state.get_workspace_state())
end)
