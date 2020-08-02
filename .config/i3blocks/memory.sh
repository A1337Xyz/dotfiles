#!/usr/bin/env bash
case "$BLOCK_BUTTON" in
    1|2) urxvt -title floating -e top -o %MEM ;; 
esac

val=$(free | awk '/Mem/{print ($3*100)/$2}')
printf ' MEM %.0f%% \n' "$val"

[ "${val%.*}" -gt 80 ] && exit 33
