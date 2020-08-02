#!/usr/bin/env bash
case "$BLOCK_BUTTON" in
    1|2) urxvt -title floating -e nnn ~  ;; 
esac

val=$(df -h /home | awk 'END{print $5}')

echo "  $val "
[ "${val%?}" -gt 90 ] && exit 33 
