#!/usr/bin/env sh

# Required for Wayland notifications
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

BATTERY_STATE="$1"
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -Po '[0-9]+(?=%)')

case "$BATTERY_STATE" in
  charging)
    TITLE="Charging"
    ICON="battery-charging"
    ;;
  discharging)
    TITLE="Discharging"
    ICON="battery"
    ;;
esac

notify-send "$TITLE" "$BATTERY_LEVEL% battery" -i "$ICON" -t 5000 -r 9991
