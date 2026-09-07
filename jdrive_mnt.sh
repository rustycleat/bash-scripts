#!/usr/bin/env bash

TARGET_IP="192.168.0.4"
SHARE_NAME="Jdrive"
MOUNT_POINT="/mnt/jdrive"

# Ensure mount point exists
sudo mkdir -p "$MOUNT_POINT"

echo "Mounting //$TARGET_IP/$SHARE_NAME to $MOUNT_POINT..."

sudo mount -t cifs "//$TARGET_IP/$SHARE_NAME" "$MOUNT_POINT" -o guest,uid=$(id -u),gid=$(id -g)

if mountpoint -q "$MOUNT_POINT"; then
    echo "[+] Mounted successfully at $MOUNT_POINT"
else
    echo "[-] Failed to mount share."
fi
