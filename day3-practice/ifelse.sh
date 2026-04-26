#!/bin/bash

AGE=20

if [ $AGE -ge 18 ]; then
    echo 'You are an adult'
else
    echo 'You are a minor'
fi

FILE='testfile.txt'

if [ -f $FILE ]; then
    echo "$FILE exists"
else
    echo "$FILE does not exist — creating it"
    touch $FILE
fi

FOLDER='myfolder'

if [ -d $FOLDER ]; then
    echo "$FOLDER folder exists"
else
    echo "$FOLDER does not exist — creating it"
    mkdir $FOLDER
fi

if [ -z "$1" ]; then
    echo 'No argument passed'
    echo 'Usage: ./ifelse.sh <your_name>'
else
    echo "Hello $1 — argument received!"
fi

SCORE=75

if [ $SCORE -ge 90 ]; then
    echo 'Grade: A'
elif [ $SCORE -ge 75 ]; then
    echo 'Grade: B'
elif [ $SCORE -ge 60 ]; then
    echo 'Grade: C'
else
    echo 'Grade: F'
fi
