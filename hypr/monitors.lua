-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

hl.monitor({ output = "desc:Chimei Innolux Corporation 0x139D", mode = "preferred", position = "auto", scale = 1 })

hl.monitor({ output = "desc:Dell Inc. DELL AW2723DF 5QKRNP3", mode = "2560x1440@239.97", position = "auto", scale = 1 })
hl.monitor({ output = "desc:XXX Beyond TV 0x00010000", mode = "preferred", position = "auto-up", scale = 2 })
hl.monitor({
	output = "desc:Beihai Century Joint Innovation Technology Co.Ltd 35D501",
	mode = "preferred",
	position = "auto-up",
	scale = 1,
})
