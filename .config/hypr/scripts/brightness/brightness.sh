#!/bin/bash

# Usage:
# ./brightness.sh +5
# ./brightness.sh -10
# ./brightness.sh 5

MIN_PERCENT=5 # 👈 minimum allowed brightness

if [ -z "$1" ]; then
    echo "Usage:"
    echo "  $0 +5   (increase)"
    echo "  $0 -5   (decrease)"
    echo "  $0 5    (set absolute)"
    exit 1
fi

arg="$1"

b_max=$(brightnessctl max)
current=$(brightnessctl get)

min_val=$((b_max * MIN_PERCENT / 100))

# Detect mode
if [[ "$arg" =~ ^[+-][0-9]+$ ]]; then
    # RELATIVE MODE
    sign=${arg:0:1}
    percent=${arg:1}

    delta=$((b_max * percent / 100))

    if [ "$sign" = "+" ]; then
        target=$((current + delta))
    else
        target=$((current - delta))
    fi

elif [[ "$arg" =~ ^[0-9]+$ ]]; then
    # ABSOLUTE MODE
    percent="$arg"
    target=$((b_max * percent / 100))

else
    echo "Invalid input!"
    exit 1
fi

# LIMIT PROTECTION
[ "$target" -gt "$b_max" ] && target=$b_max
[ "$target" -lt "$min_val" ] && target=$min_val # 👈 enforce min 5%

step=1

# Smooth transition
while :; do
    now=$(brightnessctl get)

    [ "$now" -eq "$target" ] && break

    if [ "$now" -lt "$target" ]; then
        swayosd-client --brightness +$step
    else
        swayosd-client --brightness -$step
    fi

    sleep 0.01
done
