#!/usr/bin/env bash
#[ $BLOCK_BUTTON -eq 1 ] && pactl set-sink-mute @DEFAULT_SINK@ toggle
[ $BLOCK_BUTTON -eq 1 ] && kitty --name floating_terminal pulsemixer
#IFS=% read -r -a out < <(amixer get Master | awk -F'[][]' '{print $2,$6}' | tail -n1) 
#volume=${out[0]}
#_status=${out[1]}
volume=$(pactl list sinks | sed 's/\s*//;s/%//' | grep ^Volume | awk '{print $5}')
if [ $volume -le 10 ] || pactl list sinks | grep -q 'Mute: yes';then
    echo "  "
elif [ $volume -lt 50 ];then
    echo " $volume%  " 
else
    echo " $volume%  "
fi

exit 0
