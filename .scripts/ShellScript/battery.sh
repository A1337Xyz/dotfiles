#!/usr/bin/env bash
[ $(pgrep -u 1000 -fc battery.sh) -gt 1 ] && exit 1
set -e
notified=0
while pgrep Xorg;do
    BAT=$(acpi | grep -oP '[0-9]*(?=%)')
    if acpi | grep -q Discharging;then
        [ $BAT -le 16 ] && [ $notified -eq 0 ] && {
            notify-send -u critical "$(acpi)";
            notified=1;
        }
    else
        notified=0
        [ $BAT -ge 99 ] && notify-send "$(acpi)"
    fi
    sleep 60
done
