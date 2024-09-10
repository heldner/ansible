#!/bin/sh

case "$1" in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ --limit 1 ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- --limit 1 ;;
    *)
        exit 0 ;;
esac

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print ($2*100)}')

if [ "$volume" -le 33 ]; then
    level='low'
elif [ "$volume" -le 66 ]; then
    level='medium'
else
    level='high'
fi

dunstify -a "changeVolume" \
    -u low \
    -i "/usr/share/icons/Faba/symbolic/status/audio-volume-$level-symbolic.svg" \
    -h string:x-dunst-stack-tag:"vol" \
    -h int:value:"$volume" "Volume: ${volume}%"
