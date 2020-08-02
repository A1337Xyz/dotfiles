#!/bin/sh
case "$BLOCK_BUTTON" in
    1|2) urxvt -name floating_terminal -geometry 20x10-9+22 -e bash -c 'cal && sleep 6'  ;; 
esac
#date '+  %H:%M '
date '+ %A %d %B %H:%M '

