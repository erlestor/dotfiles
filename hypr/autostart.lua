--- Extra autostart processes
-- o.launch_on_start("my-service")

-- o.launch_on_start("hyprpm reload -n")
o.launch_on_start("sleep 1 && hyprctl dispatch focusmonitor DP-2")

-- Force ninja-brain bot to use x11 clipboard
-- I need it for ninjabrain-bot in mcsr
-- Hope it doesn't fuck with my other copying
-- o.launch_on_start("~/.config/scripts/mc-clipboard-bridge.sh")
--
-- o.launch_on_start("sudo systemctl enable keyd --now")
-- o.launch_on_start("keyd-application-mapper -d")

-- force hyprsunset to start. it just doesnt by default idk
o.launch_on_start("hyprsunset")

-- open steam in the background on start. to keep overwatch updated and shaders cached
o.launch_on_start("steam -silent")
