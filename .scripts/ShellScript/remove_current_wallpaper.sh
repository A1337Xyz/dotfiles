#!/usr/bin/env bash
set -e
curr_wallpaper="$(awk -F'"' 'END{print $2}' ~/.cache/xwallpaper)"
if [ -f "$curr_wallpaper" ];then
    #sxiv -fopq "$curr_wallpaper" | xargs -rI{} rm -v {} 2>&1 | xargs -r notify-send
    if [ $(printf 'Yes\nno' | dmenu -i -p "remove \"$curr_wallpaper\"?") = "Yes" ];then
        rm -v "$curr_wallpaper" | xargs -r notify-send
        xwall.sh
    fi
fi
