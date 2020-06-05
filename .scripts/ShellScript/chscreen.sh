#!/bin/sh
printf 'LVDS-1\nDVI-D-1\nVGA-1' | dmenu -i | xargs -rI{} xrandr --output {} --auto
[ -x ~/.cache/xwallpaper ] && . ~/.cache/xwallpaper
