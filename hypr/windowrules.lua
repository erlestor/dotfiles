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

-- MCSR
hl.window_rule({ match = { class = "waywall" }, fullscreen = true, monitor = "1" })
