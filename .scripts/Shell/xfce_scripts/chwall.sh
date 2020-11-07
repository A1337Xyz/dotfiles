#!/bin/sh
set_wallpaper() {
    [ -f "$1" ] || return 1
    local img=$(realpath "$1")
    [ -f "$XDG_CACHE_HOME"/xwallpaper ] && rm -f "$XDG_CACHE_HOME"/xwallpaper
    echo "xwallpaper --strecth \"$img\"" > "$XDG_CACHE_HOME"/xwallpaper
    monitor=$(xrandr --listactivemonitors | awk '/[0-9]:/{print $2}' |
        sed 's/+//;s/*//' | tail -n1)
    xfconf-query \
    -c xfce4-desktop \
    -p /backdrop/screen0/monitor$monitor/workspace0/last-image \
    -s "$img"
}
case "$1" in
    --dmenu)
        target="$HOME"/Pictures/wallpapers/"$(
            find "$HOME"/Pictures/wallpapers -mindepth 1 -type d |
                grep -o '[^/]*$' | dmenu -c -i -l 10
        )"
        set_wallpaper "$(find "$target" -iname '*.jpg' | shuf -n1)"
        ;;
    *)
        if [ -f "$1" ];then
            set_wallpaper "$1"
        elif [ -d "$1" ];then
            set_wallpaper "$(sxiv -qo "$1")"
        else
            target="$HOME"/Pictures/wallpapers
            set_wallpaper "$(find "$target" -iname '*.jpg' | shuf -n1)"
        fi
        ;;
esac
