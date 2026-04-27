#!/bin/bash

DATE=$(date '+%Y-%m-%d %H:%M:%S')
THRESHOLD=85

TOTAL=$(free | grep Mem | awk '{print $2}')
USED=$(free | grep Mem | awk '{print $3}')
PCT=$(( USED * 100 / TOTAL ))

echo "[$DATE] Memory check: ${PCT}% used"

if [ $PCT -gt $THRESHOLD ]; then
    echo "WARNING: Memory is critically high: ${PCT}%"
else
    echo "OK: Memory is healthy: ${PCT}%"
fi
