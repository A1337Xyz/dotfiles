#!/bin/sh

case $1 in
    focused)
        scrot -q 100 -u "$HOME/Pictures/screenshots/screenshot_%H%M%S_%d%m%Y.png" -e 'notify-send $f'
    ;;
    select)
        sleep 1 ; scrot -q 100 -s "$HOME/Pictures/screenshots/screenshot_%H%M%S_%d%m%Y.png" -e 'notify-send $f'
    ;;
    copy)
        scrot -q 100 "/tmp/screenshot_%H%M%S_%d%m%Y.png" \
            -e 'xclip -sel clip -t image/png -i $f; notify-send $f'
    ;;
    copy-focused)
        scrot -q 100 -u "/tmp/screenshot_%H%M%S_%d%m%Y.png" \
            -e 'xclip -sel clip -t image/png -i $f; notify-send $f'
    ;;
    copy-select)
        sleep .5 ; scrot -q 100 -s "/tmp/screenshot_%H%M%S_%d%m%Y.png" \
            -e 'xclip -sel clip -t image/png -i $f; notify-send $f'
    ;;
    *) scrot -q 100 -m "$HOME/Pictures/screenshots/screenshot_%H%M%S_%d%m%Y.png" -e 'notify-send $f' ;;
esac
