#!/bin/bash
wl-paste --watch sh -c '
    TITLE=$(hyprctl activewindow -j | grep -o '"'"'"title": "[^"]*"'"'"' | head -1)
    if echo "$TITLE" | grep -qi "minecraft"; then
        wl-paste | xclip -selection clipboard
    fi
'
