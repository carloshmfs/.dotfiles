#!/usr/bin/env bash

is_in_sync=0

date +"%a %d/%m - %H:%M"

while true
do
    if [ $is_in_sync -eq 0 ]; then
        if [ $(($(date +"%S") % 5)) -eq 0 ]; then is_in_sync=1; fi
        continue
    fi

    date +"%a %d/%m - %H:%M"
    if [ $(($(date +"%S") % 5)) -ne 0 ]; then is_in_sync=0; fi

    sleep 5
done
