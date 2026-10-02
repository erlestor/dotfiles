--- Extra autostart processes
-- o.launch_on_start("my-service")

o.launch_on_start("sleep 1 && hyprctl dispatch 'hl.dsp.focus({ monitor = \"DP-2\" })'") -- focus the main monitor on desktop
o.launch_on_start("hyprsunset") -- force hyprsunset to adjust on start
o.launch_on_start("steam -silent") -- keep shader cahce updating in the background
