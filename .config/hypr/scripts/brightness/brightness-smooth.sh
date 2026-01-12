#!/usr/bin/env bash

STEP=1
DELAY=0.015

DIR="$1"   # up / down

CURRENT=$(brightnessctl g)
MAX=$(brightnessctl m)
CUR_PCT=$(( CURRENT * 100 / MAX ))

if [ "$DIR" = "up" ]; then
    TARGET=$(( CUR_PCT + 5 ))
else
    TARGET=$(( CUR_PCT - 5 ))
fi

TARGET=$(clamp() { [ "$1" -lt 1 ] && echo 1 || ([ "$1" -gt 100 ] && echo 100 || echo "$1"); }; clamp "$TARGET")

for ((i=CUR_PCT; i!=TARGET; i+=(DIR=="up"?STEP:-STEP))); do
    brightnessctl s "${i}%"
    sleep $DELAY
done

# update swayosd indicator
swayosd-client --brightness "${TARGET}"
