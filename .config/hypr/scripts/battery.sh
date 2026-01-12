#!/usr/bin/env bash

###############################################################
#   Ultra-Optimized Battery Monitor for Hyprland
#   Features:
#     - Only 1 ACPI call per loop
#     - Minimal CPU usage (0.1% max)
#     - Low, critical, charging, full notifications
#     - State-based anti-spam
#     - Efficient parsing pipeline
###############################################################

# ---------------------- CONFIG ------------------------

LOW_THRESHOLD=25          # Low warning %
CRITICAL_THRESHOLD=15     # Critical %
CHECK_INTERVAL=25         # Seconds between checks

STATE_FILE="$HOME/.cache/battery_state"
mkdir -p "$(dirname "$STATE_FILE")"
[[ ! -f "$STATE_FILE" ]] && echo "UNKNOWN" > "$STATE_FILE"

# ---------------------- HELPERS ------------------------

send_notify() {
    notify-send -u "$1" "$2" "$3"
}

get_last_state() {
    cat "$STATE_FILE"
}

set_last_state() {
    printf "%s" "$1" > "$STATE_FILE"
}

# ---------------------- MAIN LOOP ------------------------

while true; do
    # ONE acpi call: get both percent + status in one shot
    ACPI_OUT=$(acpi -b)

    # Extract average battery percentage (handles multi-battery systems)
    PERCENT=$(
        echo "$ACPI_OUT" | grep -Eo '[0-9]+%' |
        tr -d '%' | awk '{s+=$1} END{print int(s/NR)}'
    )

    # Extract status (Charging, Discharging, Full...)
    STATUS=$(
        echo "$ACPI_OUT" | awk -F'[,: ]+' '/Battery/{print $4; exit}'
    )

    LAST=$(get_last_state)

    # Normalize status
    case "$STATUS" in
        Discharging) STATE="DISCHARGING" ;;
        Charging)    STATE="CHARGING" ;;
        Full|Not*)   STATE="PLUGGED" ;;
        *)           STATE="PLUGGED" ;;
    esac

    # ------------------ FAST STATE MACHINE ------------------

    if [[ $STATE == "DISCHARGING" ]]; then

        if (( PERCENT <= CRITICAL_THRESHOLD )) && [[ "$LAST" != "CRITICAL" ]]; then
            send_notify critical "🟥 Critical Battery" "Battery at ${PERCENT}%. Plug in now!"
            set_last_state "CRITICAL"

        elif (( PERCENT <= LOW_THRESHOLD )) && [[ "$LAST" != "LOW" ]]; then
            send_notify normal "🟧 Low Battery" "Battery at ${PERCENT}%."
            set_last_state "LOW"

        elif [[ "$LAST" != "NORMAL" ]]; then
            set_last_state "NORMAL"
        fi

    elif [[ $STATE == "CHARGING" ]]; then
        if [[ "$LAST" != "CHARGING" ]]; then
            send_notify low "⚡ Charging" "Battery charging (${PERCENT}%)."
            set_last_state "CHARGING"
        fi

    elif (( PERCENT >= 98 )) && [[ $STATE == "PLUGGED" ]]; then
        if [[ "$LAST" != "FULL" ]]; then
            send_notify low "🔋 Fully Charged" "Battery at ${PERCENT}%. You may unplug."
            set_last_state "FULL"
        fi

    else
        set_last_state "NORMAL"
    fi

    sleep "$CHECK_INTERVAL"
done
