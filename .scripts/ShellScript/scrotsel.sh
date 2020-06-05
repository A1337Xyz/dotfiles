#!/usr/bin/env bash
set -e
output=~/screenshot_$(date +%H%M%S_%d%m%Y).png
scrot -s -q 100 "$output"
[ $(printf 'yes\nno' | dmenu -p "Save '$output'?" -i) != 'yes' ] && rm "$output" 

