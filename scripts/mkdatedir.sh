#!/bin/bash

year="$1"
month="$2"
day="$3"

if [[ -z $4 ]]; then
    start_day=1
else
    start_day="$4"
fi

for (( i="$start_day"; i<="$3"; i++ )); do
    if [ "$i" -lt 10 ]; then
        a=0"$i"
        mkdir "$year"-"$month"-"$a"
    else 
        mkdir "$year"-"$month"-"$i"
    fi
done
