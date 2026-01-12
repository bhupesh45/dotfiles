#!/usr/bin/env sh

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

LAST_STATE=""

while true; do
  # INFO=$(acpi -b | grep "Battery 0")
  #
  # if echo "$INFO" | grep -q "Charging"; then
  #   STATE="charging"
  # elif echo "$INFO" | grep -q "Discharging"; then
  #   STATE="discharging"
  # else
  #   sleep 10
  #   continue
  # fi
  #
  # if [ "$STATE" != "$LAST_STATE" ]; then
  #   ~/.config/hypr/scripts/battery/battery-charging.sh "$STATE"
  #   LAST_STATE="$STATE"
  # fi

  ~/.config/hypr/scripts/battery/battery-alert.sh

  sleep 60
done
