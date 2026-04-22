#!/bin/bash
# My first shell script — Day 1 of DevOps Bootcamp
xxecho '==============================='
echo 'SYSTEM INFORMATION'
echo '==============================='
echo ''
echo 'Hostname:'
hostname
echo ''
echo 'Current user:'
whoami
echo ''
echo 'Current date and time:'
date
echo ''
echo 'Disk usage:'
df -h /
echo ''
echo 'Memory usage:'
free -h
echo ''
echo 'Script complete!'
