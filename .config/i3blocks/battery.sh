#!/usr/bin/env bash
case "$BLOCK_BUTTON" in
    1|2) notify-send "$(acpi)" ;; 
esac

function main() {
    local capacity=$(cat /sys/class/power_supply/BAT?/capacity)
    local status=$(cat /sys/class/power_supply/BAT?/status)
    
    case "${status}" in
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

    if [ "$status" = Charging ];then
        echo "CHR $capacity%"
    else
        echo "BAT $capacity%"
    fi
}
main

