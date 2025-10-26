local utils = require("utils")

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

-- SMART WORKSPACE SWITCHER
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

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
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line) -- buggy with unix domain
					-- attempted fix:
					-- TODO:
					-- we're getting the incorrect window. bcuz promptinputline changes window and pane etc.
					-- wezterm.log_info("Window ID:")
					-- wezterm.log_info(window:window_id())
					-- local tab_id = window:active_tab():tab_id()
					-- wezterm.log_info("Tab ID:")
					-- wezterm.log_info(tab_id)
					--
					-- wezterm.sleep_ms(1000)
					--
					-- window:perform_action(
					-- 	wezterm.action.SpawnCommandInNewTab({
					-- 		args = {
					-- 			"wezterm",
					-- 			"cli",
					-- 			"set-tab-title",
					-- 			"--tab-id",
					-- 			tostring(tab_id),
					-- 			line,
					-- 		},
					-- 	}),
					-- 	pane
					-- )
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
		key = "L",
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
	-- SMART WORKSPACE SWITCHER
	{ mods = "CTRL", key = "f", action = workspace_switcher.switch_workspace() },
	-- quickly enter most used workspaces
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action_callback(function(window, pane)
			local label = "config"

			local workspace_exists = utils.workspace_exists(label)

			window:perform_action(act.SwitchToWorkspace({ name = label }), pane)

			if workspace_exists then
				return
			end

			wezterm.sleep_ms(100)
			window:perform_action(act.EmitEvent("es-workspace-switched-with-hotkey"), pane)
		end),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action_callback(function(window, pane)
			local label = ""
			if is_windows then
				label = [[~\Documents\Koding\cot\deploii]]
			else
				label = "~/Documents/koding/cot/deploii"
			end

			local workspace_exists = utils.workspace_exists(label)

			window:perform_action(act.SwitchToWorkspace({ name = label }), pane)

			if workspace_exists then
				return
			end

			wezterm.sleep_ms(100)
			window:perform_action(act.EmitEvent("es-workspace-switched-with-hotkey"), pane)
		end),
	},

	-- DOMAINS
	-- these are mostly for testing out how domains work
	{
		mods = "LEADER",
		key = "a",
		action = act.Multiple({
			act.AttachDomain("sessions"),
			-- act.DetachDomain({ DomainName = "SSHMUX:deploii" }),
		}),
	},
	{
		mods = "LEADER",
		key = "d",
		action = act.DetachDomain({ DomainName = "sessions" }),
	},
	{
		-- DONT USE. Use wssh deploii instead
		-- SSH deploii
		-- only run on fresh terminal launch. In default workspace
		-- for now...
		mods = "LEADER",
		key = "s",
		action = act.Multiple({
			-- doesn't really work?``
			act.AttachDomain("SSHMUX:deploii"),
			-- act.DetachDomain({ DomainName = "sessions" }),
		}),
	},
	-- RESURRECT
	-- Might need these for debug
	-- save session manually. uncomment for debug
	{
		mods = "LEADER|SHIFT",
		key = "S",
		action = wezterm.action_callback(function(_, _)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
			wezterm.log_info("(Resurrect) Workspace saved")
		end),
	},
	-- {
	-- 	-- Delete a saved session using a fuzzy finder
	-- 	mods = "LEADER|SHIFT",
	-- 	key = "d",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
	-- 			resurrect.state_manager.delete_state(id)
	-- 		end, {
	-- 			title = "Delete State",
	-- 			description = "Select session to delete and press Enter = accept, Esc = cancel, / = filter",
	-- 			fuzzy_description = "Search session to delete: ",
	-- 			is_fuzzy = true,
	-- 		})
	-- 	end),
	-- },
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
