#!/usr/bin/env bash

echo "Scanning for active network mounts under /mnt..."

# Find all network filesystems (cifs, nfs, nfs4, smbfs, sshfs) mounted under /mnt
NETWORK_MOUNTS=$(awk '$2 ~ /^\/mnt\// && $3 ~ /^(cifs|smbfs|nfs|nfs4|sshfs)$/ {print $2}' /proc/mounts)

if [ -z "$NETWORK_MOUNTS" ]; then
    echo "[*] No active network mounts found under /mnt."
    exit 0
fi

for MOUNT in $NETWORK_MOUNTS; do
    echo "Unmounting $MOUNT..."
    sudo umount "$MOUNT"

    if ! mountpoint -q "$MOUNT"; then
        echo "  [+] Successfully unmounted $MOUNT"
    else
        echo "  [-] Failed to unmount $MOUNT (device busy? Try closing open files or terminal sessions in this directory)"
    fi
done
