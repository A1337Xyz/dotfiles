#!/usr/bin/env bash

mode=$(cat << EOF | dmenu -i -l 6
1: HDMI1 left of eDP1
2: HDMI1 right of eDP1
3: eDP1 left of HDMI1
4: eDP1 right of HDMI1
5: HDMI1 only
6: eDP1 only
7: HDMI1 same as eDP1
EOF
)
echo $mode

case ${mode:0:1} in
    1) xrandr --output HDMI1 --left-of eDP1 --auto ;;
    2) xrandr --output HDMI1 --right-of eDP1 --auto ;;
    3) xrandr --output eDP1 --right-of HDMI1 --auto ;;
    4) xrandr --output eDP1 --right-of HDMI1 --auto ;;
    5) xrandr --output eDP1 --off --output HDMI1 --auto ;;
    6) xrandr --output HDMI1 --off --output eDP1 --auto ;;
    7) xrandr --output HDMI1 --same-as eDP1 ;;
    *) exit 1 ;;
esac

sleep 5 && . ~/.cache/xwallpaper
