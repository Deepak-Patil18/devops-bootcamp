#!/bin/bash

NAME='Deepak'
AGE=25
CITY='Pune'

echo "My name is $NAME"
echo "I am $AGE years old"
echo "I live in $CITY"

TODAY=$(date +%Y-%m-%d)
HOSTNAME=$(hostname)
DISK_FREE=$(df -h / | tail -1 | awk '{print $4}')

echo "Today is: $TODAY"
echo "Server: $HOSTNAME"
echo "Free disk: $DISK_FREE"

echo "Script name: $0"
echo "First argument: $1"
echo "Second argument: $2"
echo "Total arguments: $#"
