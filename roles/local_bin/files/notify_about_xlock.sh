#!/bin/sh

PATH=/usr/bin

close_dunst() {
    sleep 10
    dunstctl close-all
}

close_dunst &

exec notify-send \
    --icon /usr/share/icons/Adwaita/48x48/legacy/emblem-urgent.png \
    -u critical \
    'xautolock' 'will lock in less than minute'
