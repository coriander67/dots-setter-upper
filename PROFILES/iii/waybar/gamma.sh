#!/bin/bash

STATE_FILE="$HOME/.cache/waybar/gammastep_state"
[ -f "$STATE_FILE" ] || echo "0" > "$STATE_FILE"
CURRENT=$(cat "$STATE_FILE")

# If an argument is passed, treat it as how much to increment
if [[ -n "$1" ]]; then
    CURRENT=$(( (CURRENT + $1) % 3 ))
    echo "$CURRENT" > "$STATE_FILE"

    # Apply preset
    PRESETS=("1.0 1.0 6500" "0.8 0.8 4000" "3.0 3.0 6500")
    IFS=' ' read -r R G TEMP <<< "${PRESETS[$CURRENT]}"
    pkill -f "gammastep -g" 2>/dev/null
    gammastep -g "${R}:${G}:${G}" -O "$TEMP" >/dev/null 2>&1 &
fi

# Output icon for Waybar
case "$CURRENT" in
    0) ICON="󰖨" ;;  # dim/night
    1) ICON="󰖔" ;;  # normal
    2) ICON="󰖧" ;;  # bright
    *) ICON="󰖨" ;;  # fallback
esac
echo "{\"text\":\"$ICON\"}"
