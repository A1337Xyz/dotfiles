#!/usr/bin/env bash

val=$(acpi | grep -o '[0-9]*%' | awk 'END {print $1}')

echo "BAT $val"
[ "${val%?}" -lt 15 ] && acpi | grep -q Discharging && exit 33
