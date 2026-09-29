#!/bin/bash

TOPIC_URL="https://ntfy.sh/noesis2549-server-alerts"

# System info
HOST=$(hostname)
UPTIME=$(uptime -p)
LOAD=$(cut -d ' ' -f 1-3 /proc/loadavg)
DISK=$(df -h / | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')

MESSAGE="Heartbeat from $HOST
Time: $(date)
Uptime: $UPTIME
Load Avg: $LOAD
Disk Root: $DISK"

curl -fsS --retry 3 \
  -H "Title: Debian heartbeat" \
  -H "Priority: low" \
  -H "Tags: heart,server" \
  -d "$MESSAGE" \
  "$TOPIC_URL"

