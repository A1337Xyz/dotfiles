#!/usr/bin/env bash
weather=$(curl wttr.in/alagoas?format='%c%t')
[ ${#weather} -gt 10 ] && exit 1
[ -z "$weather" ] && exit 1
echo " $weather "

