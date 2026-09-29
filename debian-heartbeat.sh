#!/bin/bash

TOPIC_URL="https://ntfy.sh/noesis2549-server-alerts"

# System info
HOST=$(hostname)
UPTIME=$(uptime -p)
LOAD=$(cut -d ' ' -f 1-3 /proc/loadavg)
DISK=$(df -h / | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')

# Network latency (ping)
PING=$(ping -c 1 -W 1 1.1.1.1 2>/dev/null | awk -F'=' '/time=/{print $4}' | cut -d' ' -f1)
PING=${PING:-"no reply"}

# Download speed snapshot (small file)
DOWNLOAD=$(curl -o /dev/null -s -w '%{speed_download}' https://speed.cloudflare.com/__down)
# Convert bytes/sec → Mbps
DOWNLOAD_Mbps=$(awk "BEGIN {printf \"%.2f\", $DOWNLOAD / 125000}")

# Upload speed snapshot (small upload)
UPLOAD=$(curl -T /dev/null -s -w '%{speed_upload}' https://speed.cloudflare.com/__up)
UPLOAD_Mbps=$(awk "BEGIN {printf \"%.2f\", $UPLOAD / 125000}")

MESSAGE="Heartbeat from $HOST
Time: $(date)
Uptime: $UPTIME
Load Avg: $LOAD
Disk Root: $DISK
Ping: ${PING} ms
Download: ${DOWNLOAD_Mbps} Mbps
Upload: ${UPLOAD_Mbps} Mbps"

curl -fsS --retry 3 \
  -H "Title: Debian heartbeat" \
  -H "Priority: low" \
  -H "Tags: heartbeat,server,system,linux,network" \
  -d "$MESSAGE" \
  "$TOPIC_URL"

