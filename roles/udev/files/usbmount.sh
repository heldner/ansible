#!/bin/sh

set -e

DEVNODE="$2"
FS_LABEL="$3"

[ -z "$FS_LABEL" ] && FS_LABEL="$(basename "$DEVNODE")"

userid() {
    loginctl list-sessions | awk '/seat0/ {print $3}'
}

full_dir() {
    echo "/run/media/$(userid)/$1"
}

do_mount() {
    case "$ID_FS_TYPE" in
        "vfat")
            mount_options="users,gid=100,dmask=007,fmask=117,flush,relatime" ;;
        *)
            mount_options="users,gid=100,dmask=007,fmask=117,relatime" ;;
    esac
    full_dir=$(full_dir "$FS_LABEL")

    /usr/bin/install -d "$full_dir"
    if ! /usr/bin/systemd-mount --no-block --automount=yes \
        --collect "$DEVNODE" --options "$mount_options" "$full_dir"; then
        /bin/rmdir "${full_dir}"
        exit 1
    fi
    /bin/ls "$full_dir"
}

# this part run automaticaly when usb device ejected
do_umount() {
    /usr/bin/systemd-umount -u "$(full_dir "$FS_LABEL")"
    /bin/rmdir "${full_dir}"
}

usage() {
    echo "Usage: $0 <options> devname"
    exit 0
}

case "$1" in
    --mount)
        do_mount
        ;;
    --umount)
        do_umount
        ;;
    *)
        usage ;;
esac
