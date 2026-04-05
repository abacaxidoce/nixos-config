#!/bin/sh

ws_json=$(swaymsg -t get_workspaces)

echo "$ws_json" | jq -r '.[] | select(.representation != null) | .name' | sort -n | \
awk '{print "rename workspace " $1 " to " NR}' | while read -r cmd; do
    swaymsg "$cmd"
done

direction="$1"
current=$(echo "$ws_json" | jq '.[] | select(.focused).num')
max=$(echo "$ws_json" | jq '[.[] | .num] | max')
min=$(echo "$ws_json" | jq '[.[] | .num] | min')

if [ "$direction" = "left" ]; then
    if [ "$current" -le "$min" ]; then
        swaymsg workspace number "$max"
    else
        swaymsg workspace prev
    fi
else
    is_empty=$(echo "$ws_json" | jq '.[] | select(.focused).representation == null')
    
    if [ "$current" -ge "$max" ]; then
        if [ "$is_empty" = "true" ]; then
            swaymsg workspace number "$min"
        else
            swaymsg workspace number $((max + 1))
        fi
    else
        swaymsg workspace next
    fi
fi