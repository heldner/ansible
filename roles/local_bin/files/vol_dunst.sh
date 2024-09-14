#!/bin/sh

case "$1" in
up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ --limit 1
    ;;
down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- --limit 1
    ;;
toggle)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
*) exit 0 ;;
esac

src_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(echo "$src_volume" | awk '{print ($2*100)}')

if [ "$volume" -le 33 ]; then
    icon=audio-volume-low-symbolic.svg
elif [ "$volume" -le 66 ]; then
    icon=audio-volume-medium-symbolic.svg
else
    icon=audio-volume-high-symbolic.svg
fi

if echo "$src_volume" | grep -q '[MUTED]'; then
    icon=audio-volume-muted-symbolic.svg
fi

dunstify -a "changeVolume" \
    -u low \
    -i "/usr/share/icons/Faba/symbolic/status/$icon" \
    -h string:x-dunst-stack-tag:"vol" \
    -h int:value:"$volume" "Volume: $volume%"
