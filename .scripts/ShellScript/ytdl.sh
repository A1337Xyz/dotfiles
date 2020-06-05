#!/bin/sh

if [ -n "$2" ];then 
    notify-send "ytdl.sh: $2"
elif [ -n "$1" ];then
    notify-send "ytdl.sh: $1"
else
    notify-send 'ytdl.sh: nothing to do' ; exit 1
fi

cd ~/Downloads
ytdl() { youtube-dl -o '%(title)s.%(ext)s' --add-metadata "$@" 2>&1 1>&0 | xargs -r0 notify-send; }
case "$1" in
    video) ytdl -f '[height<=720]' "$2" ;;
    audio) ytdl -x "$2" ;;
    [a-Z]) ytdl "$1" ;;
esac 
