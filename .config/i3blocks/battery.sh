#!/usr/bin/env bash
case "$BLOCK_BUTTON" in
    1|2) notify-send "$(acpi)" ;; 
esac

capacity=$(cat /sys/class/power_supply/BAT?/capacity)
_status=$(cat /sys/class/power_supply/BAT?/status)
charging_color="#90AFD5"
full_color="#FFFFFF"

if (( capacity >= 0 && capacity < 20 )); then
    bat=""
elif (( capacity >= 20 && capacity < 40 )); then
    bat=""
elif (( capacity >= 40 && capacity < 60 )); then
    bat=""
elif (( capacity >= 60 )); then
    bat=""
fi

case "${_status}" in
    "Charging")
        color="$charging_color"
    ;;
    "Full")
        color="$full_color"
    ;;
    "Discharging"|"Unknown")
        if (( capacity >= 0 && capacity < 20 )); then
            color="#FF0027"
        elif (( capacity >= 20 && capacity < 40 )); then
            color="#FFB923"
        elif (( capacity >= 40 && capacity < 60 )); then
            color="#FFD000"
        elif (( capacity >= 60 )); then
            color="#20FC40"
        fi
    ;;
esac

echo "<span foreground=\"$color\"> $capacity% $bat </span>"

