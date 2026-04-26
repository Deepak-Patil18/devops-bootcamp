#!/bin/bash

say_hello() {
    echo 'Hello from a function!'
}

greet_user() {
    local USERNAME=$1
    local CITY=$2
    echo "Welcome $USERNAME from $CITY!"
}

check_disk() {
    local THRESHOLD=80
    local USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    if [ $USAGE -gt $THRESHOLD ]; then
        echo "WARNING: Disk is ${USAGE}% full!"
        return 1
    else
        echo "OK: Disk is ${USAGE}% full"
        return 0
    fi
}

say_hello
greet_user 'Deepak' 'Pune'
greet_user 'Rahul' 'Mumbai'

check_disk
if [ $? -eq 0 ]; then
    echo 'Disk check passed!'
else
    echo 'Disk check FAILED!'
fi
