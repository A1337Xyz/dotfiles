#!/usr/bin/env bash

val=$(awk '{print $1 / 1000}' /sys/devices/platform/coretemp.0/hwmon/hwmon?/temp3_input)

# echo " TEMPERATURE $val°C " 
echo " TEMP $val°C "
[ "$val" -ge 70 ] && exit 33

