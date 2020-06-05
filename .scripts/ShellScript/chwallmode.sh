#!/bin/sh
_path=~/.cache/xwallpaper
[ -f "$_path" ] || exit 1
mode=$(awk '{print $2}' "$_path")
printf ' --center\n--focus\n--maximize\n--stretch\n--tile\n--zoom' |
    dmenu -i | xargs -rI{} sed -i 's/'$mode'/'{}'/' "$_path"
. "$_path"
