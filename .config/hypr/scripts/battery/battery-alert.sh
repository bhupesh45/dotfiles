#!/usr/bin/env sh

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

WARNING_LEVEL=20
CRITICAL_LEVEL=10

BATTERY_INFO=$(acpi -b | grep "Battery 0")
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep -Po '[0-9]+(?=%)')
DISCHARGING=$(echo "$BATTERY_INFO" | grep -c "Discharging")

FULL_FILE=/tmp/batteryfull
EMPTY_FILE=/tmp/batteryempty
CRITICAL_FILE=/tmp/batterycritical

# Reset flags
if [ "$DISCHARGING" -eq 1 ]; then
  rm -f "$FULL_FILE"
else
  rm -f "$EMPTY_FILE" "$CRITICAL_FILE"
fi

if [ "$BATTERY_LEVEL" -ge 80 ] && [ "$DISCHARGING" -eq 0 ] && [ ! -f "$FULL_FILE" ]; then
  notify-send "Battery Full" "Unplug charger" -i battery-full -r 9991
  touch "$FULL_FILE"

elif [ "$BATTERY_LEVEL" -le "$CRITICAL_LEVEL" ] && [ "$DISCHARGING" -eq 1 ] && [ ! -f "$CRITICAL_FILE" ]; then
  notify-send "Battery Critical" "Plug in charger NOW!" -u critical -i battery-caution -r 9991
  touch "$CRITICAL_FILE"

elif [ "$BATTERY_LEVEL" -le "$WARNING_LEVEL" ] && [ "$DISCHARGING" -eq 1 ] && [ ! -f "$EMPTY_FILE" ]; then
  notify-send "Low Battery" "$BATTERY_LEVEL% remaining" -u critical -i battery-low -r 9991
  touch "$EMPTY_FILE"
fi
