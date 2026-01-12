#!/usr/bin/env bash

STEP=0.2   # change to 0.1 / 0.25 if you want
MIN=1
MAX=4

CURRENT=$(hyprctl getoption cursor:zoom_factor | awk '/float/ {print $2}')

if [ "$1" = "in" ]; then
  NEW=$(awk "BEGIN {print $CURRENT + $STEP}")
else
  NEW=$(awk "BEGIN {print $CURRENT - $STEP}")
fi

# Clamp values
if awk "BEGIN {exit !($NEW < $MIN)}"; then NEW=$MIN; fi
if awk "BEGIN {exit !($NEW > $MAX)}"; then NEW=$MAX; fi

hyprctl keyword cursor:zoom_factor "$NEW"
