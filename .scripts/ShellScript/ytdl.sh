#!/bin/sh

[ -z "$1" ] && { notify-send 'ytdl.sh: nothing to do' ; exit 1 ; }

cd ~/Downloads
notify-send "ytdl.sh: $1"
echo -e '\033]2;'"youtube-dl: $1"'\007'
youtube-dl -o '%(title)s.%(ext)s' --add-metadata "$1" 2>&1 1>&0 | xargs -r0 notify-send;

