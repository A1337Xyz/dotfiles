#!/usr/bin/env bash
case "$BLOCK_BUTTON" in
    1|2) urxvt -title floating -e watch -n 5 -t sensors  ;; 
esac

val=$(awk '{print $1 / 1000}' /sys/devices/platform/coretemp.0/hwmon/hwmon?/temp3_input)

if (( val < 42 ));then
    color="#00C0FF"
elif (( val >= 42 && val < 55 ));then
    color="#80C0FF"
else
    color="#C0C0FF"
fi

echo " TEMP <span foreground=\"$color\">$val°C</span> "
[ "$val" -ge 70 ] && exit 33

