#!/bin/bash

while true; do
    # Count connected monitors using xrandr
    monitors=$(xrandr --query 2>/dev/null | grep -c " connected")
    status=$(playerctl status 2>/dev/null)

    if [[ "$monitors" -ge 3 ]] && [[ "$status" == "Playing" ]] && ! pgrep -x cava > /dev/null; then
        alacritty --class cava -e cava &
    elif ([[ "$monitors" -lt 3 ]] || [[ "$status" != "Playing" ]]) && pgrep -x cava > /dev/null; then
        pkill -x cava
    fi

    sleep 1
done

