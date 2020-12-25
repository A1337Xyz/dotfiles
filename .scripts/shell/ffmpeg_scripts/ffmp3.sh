#!/usr/bin/env bash
output="${1%.*}.mp3"
c=1
while [ -a "$output" ];do
    output="${c}_${1%.*}.mp3"
    c=$((c+1))
done
printf '%s \e[1;37m~\e[34m>\e[m %s\n' "$1" "$output"

ffmpeg -hide_banner -v 16 -i "$1" -vn -c:a -libmp3lame -q:a 5 "$output"

[ $? -ne 0 ] && { rm -v "$output"; exit 1; }
exit 0
