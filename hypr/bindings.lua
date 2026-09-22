-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
-- omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- MY DOCUMENTATION
-- o.bind implementation (as of now)
-- function o.bind(keys, description, dispatcher, options)
--   local opts = options or {}
--   hl.unbind(keys)
--   o.bind(keys, description, dispatcher, options)
-- end

-- TUTORIAL
-- https://wiki.hypr.land/Configuring/Basics/Binds/
-- - if changing a defualt omarchy keybinding: always unbind the old keybind first

-- UNBINDING
-- apps
hl.unbind("SUPER + SHIFT + B")
hl.unbind("SUPER + SHIFT + ALT + B")
hl.unbind("SUPER + SHIFT + F")
hl.unbind("SUPER + SHIFT + ALT + F")
hl.unbind("SUPER + RETURN")
hl.unbind("SUPER + SHIFT + RETURN")
hl.unbind("SUPER + SHIFT + M")
hl.unbind("SUPER + SHIFT + O")
hl.unbind("SUPER + P")
hl.unbind("SUPER + O")
hl.unbind("SUPER + G")
hl.unbind("SUPER + SHIFT + E")
hl.unbind("SUPER + SHIFT + ALT + E")
hl.unbind("SUPER + S")
hl.unbind("SUPER + SHIFT + S")

-- window managment
hl.unbind("SUPER + SHIFT + RETURN")
hl.unbind("SUPER + SHIFT + F")
hl.unbind("SUPER + ALT + SHIFT + F")
hl.unbind("SUPER + F")
hl.unbind("SUPER + T")
hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + DOWN")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + SHIFT + LEFT")
hl.unbind("SUPER + SHIFT + DOWN")
hl.unbind("SUPER + SHIFT + UP")
hl.unbind("SUPER + SHIFT + RIGHT")

-- APPS
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + SHIFT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + F", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + SHIFT + F", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + RETURN", "Terminal", {
	launch = "alacritty --working-directory=$(omarchy-cmd-terminal-cwd) -e tmux new-session -A -s default",
})
o.bind("SUPER + SHIFT + RETURN", "SSH Deploii", {
	launch = 'alacritty --working-directory=$(omarchy-cmd-terminal-cwd) -e ssh deploii -t "tmux -f ~/.config/tmux/tmux.conf new-session -A -s erlend"',
})
o.bind("SUPER + M", "Music", { omarchy = "spotify" })
o.bind("SUPER + SHIFT + M", "MongoDB Compass", {
	launch = "mongodb-compass --password-store=gnome-libsecret --ignore-additional-command-line-flags",
	focus = "^mongodb-compass$",
})
o.bind("SUPER + T", "Activity", { tui = "btop" })
o.bind("SUPER + P", "Postman", { launch = "postman", focus = "^postman$" })
o.bind("SUPER + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.bind("SUPER + G", "Steam (gaming)", { launch = "steam", focus = "^steam$" })
o.bind("SUPER + E", "Email", { launch = "thunderbird", focus = "^thunderbird$" })

-- WEB APPS
o.bind("SUPER + D", "Discord", { webapp = "https://discord.com/channels/@me", focus = "^discord$" })

-- OTHER KEYBINDS
o.bind("SUPER + S", "Suspend/Sleep", hl.dsp.exec_cmd("systemctl suspend"))
o.bind("SUPER + SHIFT + S", "Screenshot region", hl.dsp.exec_cmd("omarchy capture screenshot"))

-- WINDOW MANAGER
-- move windows with mouse5 on my logitech mouse
o.bind("mouse:276", "Move window with mouse5", hl.dsp.window.drag(), { mouse = true })

-- toggle floating and tiling
o.bind("ALT + F", "Fullscreen current window", hl.dsp.window.fullscreen())
o.bind("ALT + T", "Float current window", hl.dsp.window.float())

-- focus windows
o.bind("ALT + H", "Focus left window", hl.dsp.focus({ direction = "l" }))
o.bind("ALT + J", "Focus down window", hl.dsp.focus({ direction = "d" }))
o.bind("ALT + K", "Focus up window", hl.dsp.focus({ direction = "u" }))
o.bind("ALT + L", "Focus right window", hl.dsp.focus({ direction = "r" }))

-- move windows in direction
o.bind("ALT + SHIFT + H", "Move window left", hl.dsp.window.move({ direction = "l" }))
o.bind("ALT + SHIFT + J", "Move window down", hl.dsp.window.move({ direction = "d" }))
o.bind("ALT + SHIFT + K", "Move window up", hl.dsp.window.move({ direction = "u" }))
o.bind("ALT + SHIFT + L", "Move window right", hl.dsp.window.move({ direction = "r" }))

-- MCSR
-- Global hotkeys (by default global hotkeys are not possible)
-- bindn means "non-consuming", eg. it also passes the key to the focused application
hl.bind("apostrophe", hl.dsp.pass({ window = "class:^(ninjabrainbot-Main)$" }), { non_consuming = true })
hl.bind("comma", hl.dsp.pass({ window = "class:^(ninjabrainbot-Main)$" }), { non_consuming = true })
hl.bind("period", hl.dsp.pass({ window = "class:^(ninjabrainbot-Main)$" }), { non_consuming = true })
