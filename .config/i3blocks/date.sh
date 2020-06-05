#!/bin/sh
case "$BLOCK_BUTTON" in
    1|2) urxvt -title floating -geometry 20x10-4+22 -e bash -c 'cal && sleep 6'  ;; 
esac
date '+ %A %d %B %H:%M '

