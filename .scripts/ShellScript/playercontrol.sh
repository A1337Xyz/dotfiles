#!/usr/bin/env bash
[ -z "$1" ] && { printf 'nothing to do\n'; exit 1; }
players=($(playerctl -l 2>/dev/null | grep -v chromium))
if [ ${#players[@]} -gt 0 ];then
    if [ ${#players[@]} -eq 1 ];then
        player=${players[0]}
    else
        player=$(playerctl -l 2>/dev/null | dmenu -p 'Player' -i)
    fi
    case $1 in
        prev) playerctl -p $player previous ;;
        next) playerctl -p $player next ;;
        toggle) playerctl -p $player play-pause ;;
    esac
elif pgrep mpd >/dev/null;then
    case $1 in
        prev) mpc -q prev ;;
        next) mpc -q next ;;
        toggle) mpc -q toggle ;;
    esac
fi
