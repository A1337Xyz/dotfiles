#!/usr/bin/env bash
[[ "$1" =~ ^[0-9]*$ ]] || exit 1
if [ $(id -u) -eq 0 ];then
    case $1 in
        [1-9]*) printf $1 > /sys/devices/virtual/backlight/psb-bl/brightness ;;
    esac
else
    outputs=($(xrandr --listactivemonitors | awk '/^\s[0-9]:/{print $2}' | sed 's/+//;s/*//'))
    case "$1" in
        [3-9])
            if [[ "${#outputs[@]}" -gt 1 ]];then
                xrandr -q | awk '/\sconnected/{print $1}' | dmenu -i | xargs -rI{} xrandr --output {} --brightness ".$1"
            else
                xrandr --output "$outputs" --brightness ".$1"
            fi
        ;;
    esac
fi
