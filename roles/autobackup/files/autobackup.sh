#!/bin/sh

USER=dayton
DEVICE=external1
BACKUP_SOURCE="/home/${USER}/.password-store"
BACKUP_DEVICE="/dev/${DEVICE}"
MOUNT_POINT="/mnt/${DEVICE}"
DEST_DIR="${MOUNT_POINT}/${USER}"

log() {
  /usr/bin/logger -p info "$@"
}

source_exists() {
  if [ ! -d "$BACKUP_SOURCE" ]; then
    log "backup source $BACKUP_SOURCE doesn't exists"
    exit 0
  fi
}

backup_device_exists() {
  if [ ! -l "$BACKUP_DEVICE" ]; then
    log "backup device $BACKUP_DEVICE doesn't exists"
    exit 0
  fi
}

mount_point_exists() {
  if [ ! -d "$MOUNT_POINT" ]; then
    /bin/mkdir "$MOUNT_POINT";
  fi
}

mount_drive() {
  if ! /bin/mount -t auto "$BACKUP_DEVICE" "$MOUNT_POINT"; then
    log "failed to mount $BACKUP_DEVICE"
    exit 0
  fi
}

backup_data() {
  if ! /usr/bin/rsync -a --delete-after "$BACKUP_SOURCE" "$DEST_DIR"; then
    log "failed to rsync $BACKUP_SOURCE to $BACKUP_DEVICE"
  fi
}

main() {
  source_exists
  backup_device_exists
  mount_point_exists
  log "backup started"
  mount_drive
  backup_data
  /bin/umount "$MOUNT_POINT"
  log "backup done"
}

main
exit
