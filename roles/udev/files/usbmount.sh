#!/bin/sh
set -e

userid() {
    loginctl list-sessions | awk '/seat0/ {print $3}'
}

full_dir() {
    echo "/run/media/$(userid)/$1"
}

mount() {
    devnode="$1"
    fs_label="$2"
    mount_options="defaults,relatime,nls=utf8,gid=100,dmask=002,fmask=113"
    full_dir=$(full_dir "$fs_label")
    /usr/bin/install -d "$full_dir"
    /usr/bin/systemd-mount --no-block --automount=yes \
        --collect "$devnode" --options "$mount_options" "$full_dir"
}

umount() {
    fs_label="$1"
    /usr/bin/systemd-umount -u "$(full_dir "$fs_label")"
}

case "$1" in
    -mount)
        shift
        mount "$1" "$2"
        ;;
    -umount)
        shift
        umount "$1"
        ;;
esac
