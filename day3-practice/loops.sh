#!/bin/bash

echo '=== Checking servers ==='
for SERVER in web01 web02 web03 db01; do
    echo "Checking: $SERVER"
done

echo ''
echo '=== Counting to 5 ==='
for i in {1..5}; do
    echo "Number: $i"
done

echo ''
echo '=== Files in day3-practice ==='
for FILE in ~/devops-bootcamp/day3-practice/*.sh; do
    echo "Found script: $FILE"
done

echo ''
echo '=== While loop countdown ==='
COUNT=3
while [ $COUNT -gt 0 ]; do
    echo "Countdown: $COUNT"
    COUNT=$((COUNT - 1))
done
echo 'Done!'

echo ''
echo '=== Even or Odd ==='
for NUM in 1 2 3 4 5 6; do
    if [ $((NUM % 2)) -eq 0 ]; then
        echo "$NUM is even"
    else
        echo "$NUM is odd"
    fi
done
