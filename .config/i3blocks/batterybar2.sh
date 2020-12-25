#!/usr/bin/env bash

bar=(   )
i=0
while :;do
    capacity=$(cat /sys/class/power_supply/BAT?/capacity)
    status=$(cat /sys/class/power_supply/BAT?/status)
    case $status in
        "Charging")
            echo "$capacity% ${bar[i]}" 
            i=$((i + 1))
            [ $i -ge ${#bar[@]} ] && i=0
            sleep 1.2
            continue
        ;;
        "Full") echo "$capacity% ${bar[3]}" ; notify-send "$(acpi)" ;;
        "Discharging"|"Unknown")
            if (( capacity >= 0 && capacity < 20 )); then
                echo "$capacity% ${bar[0]}"
            elif (( capacity >= 20 && capacity < 40 )); then
                echo "$capacity% ${bar[1]}"
            elif (( capacity >= 40 && capacity < 60 )); then
                echo "$capacity% ${bar[2]}"
            elif (( capacity >= 60 )); then
                echo "$capacity% ${bar[3]}"
            fi
        ;;
    esac
    sleep 20
done


