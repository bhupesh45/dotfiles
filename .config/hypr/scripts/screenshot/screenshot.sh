#!/bin/bash

# Directory to save screenshots
DIR="$HOME/Pictures/Screenshots"
# Filename format (e.g., Screenshot_2023-10-25_14-30-00.png)
NAME="Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

# Ensure the directory exists
mkdir -p "$DIR"

# Check for arguments
case "$1" in
"full")
    # Full screen capture
    grim "$DIR/$NAME"
    # Send notification
    notify-send "Screenshot Created" "Full screen saved to $DIR/$NAME"
    # Copy to clipboard
    wl-copy <"$DIR/$NAME"
    ;;
"area")
    # Select area or window
    grim -g "$(slurp)" "$DIR/$NAME"
    # Check if the user actually selected something (grim returns 0 on success)
    if [ $? -eq 0 ]; then
        notify-send "Screenshot Created" "Area saved to $DIR/$NAME"
        wl-copy <"$DIR/$NAME"
    else
        notify-send "Screenshot Cancelled" "No area selected"
    fi
    ;;
*)
    echo "Usage: $0 {full|area}"
    exit 1
    ;;
esac
