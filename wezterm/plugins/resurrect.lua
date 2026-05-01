local wezterm = require("wezterm")

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
