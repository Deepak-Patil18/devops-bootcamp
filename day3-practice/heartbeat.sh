#!/bin/bash

LOGFILE='/tmp/heartbeat.log'
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "$TIMESTAMP — Server is alive — User: $(whoami)" >> $LOGFILE

tail -50 $LOGFILE > /tmp/heartbeat_tmp.log
mv /tmp/heartbeat_tmp.log $LOGFILE
