#!/bin/sh
#[ $BLOCK_BUTTON -eq 1 ] && urxvt -name floating_terminal -geometry 20x10-9+22 -e bash -c 'cal && sleep 6' 
lock=~/.config/i3blocks/.data_lock
if [ $BLOCK_BUTTON -eq 1 ];then
    if [ -f "$lock" ];then
        date '+%A %d %B %H:%M'
        rm -f "$lock"
    else
        date '+%H:%M' #  
        touch "$lock"
    fi
else
    date '+%H:%M' #  
fi

