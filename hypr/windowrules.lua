-- Scroll nicely in the terminal
o.window("(Alacritty|kitty)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })
o.window("org.wezfurlong.wezterm", { scroll_touchpad = 0.6 })

-- Steam
o.window({ title = "Steam" }, { tile = true })

-- Steam games
o.window("steam_app_\\d+", { monitor = "1", fullscreen = true, opacity = "1" })

-- Exception for ubisoft connect popup
o.window("steam_app_2225070", { fullscreen = false })

-- Mcsr
o.window(
	{ title = "Minecraft\\*[ \\t]1\\.16\\.1[ \\t]-[ \\t]MCSR[ \\t]Ranked" },
	{ monitor = "1", no_anim = true, opacity = "1", rounding = 0 }
)

o.window("ninjabrainbot-Main", { monitor = "0", float = true, opacity = "1" })

o.window(
	{ initial_title = "OBS[ \\t]32\\.1\\.2[ \\t]-[ \\t]Profile:[ \\t]Untitled[ \\t]-[ \\t]Scenes:[ \\t]Untitled" },
	{ tile = true, monitor = "0" }
)
o.window({ initial_class = "com.obsproject.Studio" }, { opacity = "1" })

o.window({ initial_class = "org.prismlauncher.PrismLauncher" }, { float = true })
