#!/bin/sh
target=~/Pictures/wallpapers

if [ -z "$1" ];then
    wallpaper="$(find "$target" -iname '*.jpg' | shuf -n1)"
else
    case "$1" in
        --dmenu)
            wallpaper="$(find "$(find "$target" -maxdepth 1 -type d | dmenu -c -i -l 10)" -iname '*.jpg' | shuf -n1)" 
            ;;
        --sxiv)
            wallpaper="$(find "$target" -maxdepth 1 -type d | dmenu -c -i -l 10 | xargs -rI{} sxiv -ioqrt {})"
            ;;
        *) [ -f "$1" ] && wallpaper="$1" ;;
    esac
fi
[ -z "$wallpaper" ] && exit 1
[ -f ~/.cache/xwallpaper ] && rm -f ~/.cache/xwallpaper
echo "xwallpaper --stretch \"$wallpaper\" 2>/dev/null" > ~/.cache/xwallpaper
chmod +x ~/.cache/xwallpaper && ~/.cache/xwallpaper

