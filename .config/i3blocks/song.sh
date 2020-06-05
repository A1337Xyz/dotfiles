#!/usr/bin/env bash
song="$(playerctl metadata -f '♪ {{xesam:artist}} - {{xesam:title}}' 2>/dev/null)"
[ "${#song}" -le 5 ] && exit 1
if [ "${#song}" -gt 80 ];then
    echo "${song::77}... "
else
    echo "$song "
fi


