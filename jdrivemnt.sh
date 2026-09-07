#!/usr/bin/env bash

TARGET_IP="192.168.0.4"
SHARE_NAME="jdrive"
MOUNT_POINT="/mnt/jdrive"
USERNAME="peterc"

sudo mkdir -p "$MOUNT_POINT"

echo "Mounting //$TARGET_IP/$SHARE_NAME..."
sudo mount -t cifs "//$TARGET_IP/$SHARE_NAME" "$MOUNT_POINT" \
  -o username="$USERNAME",uid=$(id -u),gid=$(id -g)
