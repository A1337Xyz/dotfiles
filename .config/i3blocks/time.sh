#!/bin/sh
#[ $BLOCK_BUTTON -eq 1 ] && urxvt -name floating_terminal -geometry 20x10-9+22 -e bash -c 'cal && sleep 6' 
date '+%H:%M'
lock=~/.config/i3blocks/.time_lock
if [ $BLOCK_BUTTON -eq 1 ];then
    if [ -f "$lock" ];then
        urxvt -name floating_terminal -geometry 20x10-9+22 -e bash -c 'cal && sleep 8' &
        rm -f "$lock"
    else
        pkill -f 'urxvt -name floating_terminal -geometry'
        touch "$lock"
    fi
fi

