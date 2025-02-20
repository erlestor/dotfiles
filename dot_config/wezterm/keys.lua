local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- if i wanna use modals
-- local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")

local keys = {
	-- GENERIC
	{
		mods = "ALT|SHIFT",
		key = "q",
		action = act.QuitApplication,
	},
	{
		mods = "LEADER",
		key = "F",
		action = act.ToggleFullScreen,
	},
	-- TABS
	{
		mods = "LEADER",
		key = "c",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "p",
		action = act.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = act.ActivateTabRelative(1),
	},
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "&",
		mods = "LEADER|SHIFT",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	-- PANES
	{
		mods = "LEADER",
		key = "f",
		action = act.TogglePaneZoomState,
	},
	{
		mods = "LEADER",
		key = "x",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER|SHIFT",
		key = "(",
		action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
	},
	{
		mods = "LEADER",
		key = "|",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL|ALT|SHIFT",
		key = "LeftArrow",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "CTRL|ALT|SHIFT",
		key = "DownArrow",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "CTRL|ALT|SHIFT",
		key = "UpArrow",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		mods = "CTRL|ALT|SHIFT",
		key = "RightArrow",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	-- toggle vertical split
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action_callback(function(_, pane)
			local tab = pane:tab()
			local panes = tab:panes_with_info()
			if #panes == 1 then
				pane:split({
					direction = "Bottom",
					size = 0.2,
				})
			elseif not panes[1].is_zoomed then
				panes[1].pane:activate()
				tab:set_zoomed(true)
			elseif panes[1].is_zoomed then
				tab:set_zoomed(false)
				panes[2].pane:activate()
			end
		end),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action_callback(function(_, pane)
			pane:move_to_new_tab()
		end),
	},
	-- WORKSPACES
	{
		mods = "LEADER",
		key = "l",
		-- action = act.ShowLauncherArgs({ flags = "WORKSPACES|DOMAINS" }),
		action = act.ShowLauncherArgs({ flags = "WORKSPACES|DOMAINS" }),
	},
	{
		-- rename workspace
		mods = "LEADER",
		key = ".", --
		action = act.PromptInputLine({
			description = "Enter new name for workspace",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},
	{
		-- open new workspace with prompt for name. creates new workspace if none are found
		-- should add resurrect support here
		mods = "LEADER",
		key = "w",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	-- WORKSPACES | RESURRECT
	{
		-- save session manually
		key = "S",
		mods = "LEADER|SHIFT",
		action = wezterm.action_callback(function(_, _)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
		end),
	},
	{
		-- fuzzy find workspace
		key = "r",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				local opts = {
					relative = true,
					restore_text = true,
					on_pane_restore = resurrect.tab_state.default_on_pane_restore,
				}
				if type == "workspace" then
					local state = resurrect.state_manager.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, opts)
				elseif type == "window" then
					local state = resurrect.state_manager.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, opts)
				elseif type == "tab" then
					local state = resurrect.state_manager.load_state(id, "tab")
					resurrect.tab_state.restore_tab(pane:tab(), state, opts)
				end
			end)
		end),
	},
	{
		-- Delete a saved session using a fuzzy finder
		key = "d",
		mods = "LEADER|SHIFT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
				resurrect.state_manager.delete_state(id)
			end, {
				title = "Delete State",
				description = "Select session to delete and press Enter = accept, Esc = cancel, / = filter",
				fuzzy_description = "Search session to delete: ",
				is_fuzzy = true,
			})
		end),
	},
	-- DOMAINS
	{
		mods = "LEADER",
		key = "a",
		action = act.AttachDomain("unix"),
	},
	{
		mods = "LEADER",
		key = "d",
		action = act.DetachDomain({ DomainName = "unix" }),
	},
}

-- navigate to tab number n with LEADER + n
for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

return keys
