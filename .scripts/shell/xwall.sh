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
        *) 
            if [ -d "$1" ];then
                wallpaper="$(find "$(realpath "$1")" -iname '*.jpg' | shuf -n1)"
            elif [ -f "$1" ];then
                wallpaper="$(realpath "$1")"
            fi
        ;;
    esac
fi

[ -z "$wallpaper" ] && exit 1
[ -f ~/.cache/xwallpaper ] && rm -f ~/.cache/xwallpaper
echo "xwallpaper --stretch \"$wallpaper\" 2>/dev/null" > ~/.cache/xwallpaper

if [ "$DESKTOP_SESSION" = xfce ];then
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitoreDP1/workspace0/last-image -s "$wallpaper" &
else
    chmod +x ~/.cache/xwallpaper && ~/.cache/xwallpaper
    [ -n "$I3SOCK" ] && i3-msg reload
fi

