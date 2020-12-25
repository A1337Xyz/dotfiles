#!/bin/sh

[ -z "$1" ] && { notify-send 'ytdl.sh: nothing to do' ; exit 1 ; }

cd ~/Downloads
tmpfile=$(mktemp)
echo "$1" >> "$tmpfile"
notify-send "$0: $1"
printf '\033]2;%s\007' "$@"
if youtube-dl -i -o '%(title)s.%(ext)s' "$1";then
    notify-send "$0 - Download done" "$1"
    rm -f "$tmpfile"
    exit 0
else
    notify-send "$0 - Download finished with erros" "$1"
    exit 1
fi
