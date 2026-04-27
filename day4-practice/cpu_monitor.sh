#!/bin/bash

DATE=$(date '+%Y-%m-%d %H:%M:%S')
THRESHOLD=80

CPU_IDLE=$(top -bn1 | grep 'Cpu(s)' | awk '{print $8}' | cut -d. -f1)
CPU_USED=$((100 - CPU_IDLE))

echo "[$DATE] CPU check: ${CPU_USED}% used"

if [ $CPU_USED -gt $THRESHOLD ]; then
    echo "WARNING: CPU is critically high: ${CPU_USED}%"
else
    echo "OK: CPU is healthy: ${CPU_USED}%"
fi

