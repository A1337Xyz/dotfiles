#!/usr/bin/env bash
# scan the qrcode of the selected area by scrot

output=$(mktemp -u /tmp/tmp.XXXXXXXX.png)
scrot -s -q 100 "$output" || { notify-send 'scrot failed' ; exit 1; }
[ "$(printf 'yes\nno' | dmenu -p "Save \"$output\"?" -i)" != "yes" ] && { rm "$output"; exit 1; }
sleep 1
urxvt -title floating -geometry 100x40 -e bash -c "zbarimg "$output" ; read"
#rm -v "$output"
