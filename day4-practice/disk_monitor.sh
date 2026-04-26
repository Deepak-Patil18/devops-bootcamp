#!/bin/bash

THRESHOLD=80
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] Checking disk usage..."

df -h | grep -v tmpfs | tail -n +2 | while read line; do
    USAGE=$(echo $line | awk '{print $5}' | tr -d '%' | grep -E '^[0-9]+$')
    MOUNT=$(echo $line | awk '{print $6}')

    if [ ! -z "$USAGE" ] && [ "$USAGE" -gt "$THRESHOLD" ] 2>/dev/null; then
        echo "WARNING: $MOUNT is ${USAGE}% full!"
    else
        echo "OK: $MOUNT is ${USAGE}% used"
    fi
done

echo "[$DATE] Disk check complete."
