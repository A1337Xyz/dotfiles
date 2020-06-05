#!/usr/bin/env bash
case $BLOCK_BUTTON in
    1|2)
        idx=$(pacmd list-sinks | grep -e index | grep -o [0-9])
        pactl set-sink-mute $idx toggle
    ;;
esac

if pactl list sinks | grep -q 'Mute: yes';then
    echo "MUTE"
else
    VOL=$(pactl list sinks | sed 's/\s*//' | grep ^Volume | awk '{print $5}')
    echo "VOL $VOL"
fi

exit 0
