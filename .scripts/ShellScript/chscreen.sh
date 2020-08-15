#!/usr/bin/env bash

mode=$(
    printf '1: HDMI1 < eDP1\n2: HDMI1 > eDP1\n3: HDMI1\n4: eDP1' |
        dmenu -i -l 4
)

case ${mode:0:1} in
    1) xrandr --output HDMI1 --left-of eDP1 --auto ;;
    2) xrandr --output HDMI1 --right-of eDP1 --auto ;;
    3) xrandr --output eDP1 --off --output HDMI1 --auto ;;
    4) xrandr --output HDMI1 --off --output eDP1 --auto ;;
    *) exit 1 ;;
esac

sleep 5 && . ~/.cache/xwallpaper
