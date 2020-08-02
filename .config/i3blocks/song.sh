#!/usr/bin/env bash
song="$(playerctl metadata -f '♪ {{xesam:artist}} - {{xesam:title}}' 2>/dev/null)"
[ -z "$song" ] && {
    song="$(mpc current)";
    song="${song##*/}";
    song="${song%.*}";
    song="♪ $song";
}
[ "${#song}" -le 5 ] && exit 1
if [ "${#song}" -gt 83 ];then
    echo "<span foreground=\"#B0FFE8\">${song::80}...</span>"
else
    echo "<span foreground=\"#B0FFE8\">$song</span>"
fi


