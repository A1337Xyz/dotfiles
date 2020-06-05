#!/usr/bin/env bash

if [ -z "$1" ];then
    video=$(xclip -sel prim -o 2>/dev/null) 
    [ -z "$video" ] && video=$(xclip -sel clip -o 2>/dev/null) 
    [ -z "$video" ] && exit 1
else
    video="$1"
fi

lock=/tmp/.videos_dGVtcG9yYXJ5
[ -f "$lock" ] && notify-send "$(date) video added to queue" "$video"
while [ -f "$lock" ];do sleep 5 ;done

notify-send "$(date)" "$video"
touch "$lock"
trap 'rm -f $lock; exit 0' EXIT
mpv --really-quiet --ytdl-format='[height<=720]' "$video"

