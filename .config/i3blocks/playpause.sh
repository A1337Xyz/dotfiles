#!/usr/bin/env bash
case "$BLOCK_BUTTON" in
    1|2) mpc -q toggle  ;; 
esac

_status=$(mpc status | grep -oP '(?<=\[)p.*(?=\])')
case $_status in
    playing) echo "  " ;;
    paused) echo "  " ;;
esac
