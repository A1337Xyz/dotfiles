#!/bin/sh
set -e

set_wallpaper() {
    local img=$(realpath "$1")
    [ -f "$img" ] || return 1

    xwall="$XDG_CACHE_HOME"/xwallpaper
    [ -f "$xwall" ] && rm -f "$xwall"
    echo "xwallpaper --stretch \"$img\"" > "$xwall"

    xfconf-query \
    -c xfce4-desktop \
    -p /backdrop/screen0/monitoreDP1/workspace0/last-image \
    -s "$img"
}

while :;do
    set_wallpaper "$(find ~/Pictures/wallpapers -iname '*.jpg' | shuf -n1)"
    sleep 15
done & disown

