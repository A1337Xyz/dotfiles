#!/usr/bin/env bash
output="${1%.*}.mp4"
c=1
while [ -a "$output" ];do
    output="${c}_${1%.*}.mp4"
    c=$((c+1))
done
printf '%s \e[1;34m~\e[1;31m>\e[m %s\n' "$1" "$output"

ffmpeg -nostdin -hide_banner -v 16 -i "$1" \
    -c:a copy -c:v h264 -crf 28 -preset ultrafast -tune zerolatency \
    -s 1024x600 "$output"

[ $? -ne 0 ] && { rm -v "$output"; exit 1; }

exit 0
