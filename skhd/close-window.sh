#!/usr/bin/env bash
osascript <<'EOF'
tell application "System Events"
    set p to first application process whose frontmost is true
    set bid to bundle identifier of p
    set n to count of (windows of p whose subrole is "AXStandardWindow")
    if n <= 1 then
        tell application id bid to quit
    else
        click (first button of window 1 of p whose subrole is "AXCloseButton")
    end if
end tell
EOF
