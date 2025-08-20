#!/bin/bash

# apps
APPS=("Firefox" "Spotify")

# volume bar
volume_bar() {
    local volume=$1
    local muted=$2
    local bar=""
    local FILLED=$((volume / 10))
    [[ $FILLED -gt 10 ]] && FILLED=10
    local EMPTY=$((10 - FILLED))

    if [[ "$muted" == "yes" ]]; then
        bar=" "
    else
        bar=" "
    fi

    for ((i=0;i<FILLED;i++)); do bar+="▮"; done
    for ((i=0;i<EMPTY;i++)); do bar+="▯"; done

    echo "$bar"
}

# 1️⃣ system volume
output=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
volume=$(awk -v out="$output" 'BEGIN { split(out, a, " "); printf "%.0f\n", a[2] * 100 }')
muted=$( [[ "$output" == *"[MUTED]"* ]] && echo "yes" || echo "no" )
SYSTEM_BAR=$(volume_bar $volume $muted)

# json general volume
JSON="{\"text\": \"$SYSTEM_BAR\", \"tooltip\": \"Volume: ${volume}% (Click: mute, Scroll: adjust)\", \"class\": \"custom-wireplumber\"}"

# 2️⃣ apps volume
for APP in "${APPS[@]}"; do
    # session id
    IDS=$(wpctl status | grep "$APP" | awk '{print $3}' | tr -d ':')
    for ID in $IDS; do
        app_output=$(wpctl get-volume $ID 2>/dev/null)
        app_volume=$(awk -v out="$app_output" 'BEGIN { split(out, a, " "); printf "%.0f\n", a[2] * 100 }')
        app_muted=$( [[ "$app_output" == *"[MUTED]"* ]] && echo "yes" || echo "no" )
        APP_BAR=$(volume_bar $app_volume $app_muted)
        JSON+=", {\"text\": \"$APP_BAR\", \"tooltip\": \"$APP: ${app_volume}%\", \"on-click\":\"wpctl set-mute $ID toggle\", \"on-scroll-up\":\"wpctl set-volume $ID 5%+ --limit 1.0\", \"on-scroll-down\":\"wpctl set-volume $ID 5%-\"}"
    done
done

echo "$JSON"
