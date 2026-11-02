#!/usr/bin/env bash

set -euo pipefail

info="$(
    omniwmctl query windows --format json | python3 -c '
import json,sys,math

data=json.load(sys.stdin)
ws=data["result"]["payload"]["windows"]

f=[w for w in ws if w.get("isFocused")][0]

wid=f["id"]
pid=f["pid"]
bundle=f["app"]["bundleId"]
workspace=f["workspace"]["id"]

fx=f["frame"]["x"]+f["frame"]["width"]/2
fy=f["frame"]["y"]+f["frame"]["height"]/2

same_ws=[w for w in ws if w["workspace"]["id"]==workspace]
same_app=[w for w in ws if w["pid"]==pid]

target=""

others=[w for w in same_ws if w["id"]!=wid]

if others:
    target=min(
        others,
        key=lambda w: math.hypot(
            (w["frame"]["x"]+w["frame"]["width"]/2)-fx,
            (w["frame"]["y"]+w["frame"]["height"]/2)-fy
        )
    )["id"]

print(f"{wid}|{pid}|{bundle}|{len(same_app)-1}|{target}")
'
)"

IFS='|' read -r wid pid bundle remaining target <<<"$info"

omniwmctl window close "$wid"

sleep 0.05

if [[ -n "$target" ]]; then
    omniwmctl window focus "$target" >/dev/null 2>&1 || true
else
    osascript -e 'tell application "Finder" to activate' >/dev/null 2>&1
fi

if [[ "$remaining" -eq 0 ]]; then
    osascript <<EOF >/dev/null 2>&1
tell application id "$bundle"
    quit
end tell
EOF
fi
