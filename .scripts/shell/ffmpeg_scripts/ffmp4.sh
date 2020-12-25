#!/usr/bin/env bash
output="${1%.*}.mp4"
c=1
while [ -a "$output" ];do
    output="${c}_${1%.*}.mp4"
    c=$((c+1))
done
printf '%s \e[1;34m~\e[1;31m>\e[m %s\n' "$1" "$output"

# -max_muxing_queue_size 1024 : fix "too many packets buffered for output"
ffmpeg -nostdin -hide_banner -v 16 -i "$1" \
    -c:v h264 -crf 21 -profile:v baseline -pix_fmt yuv420p \
    -preset ultrafast -tune zerolatency -threads 0 "$output"

[ $? -ne 0 ] && { rm -vf "$output"; exit 1; }

exit 0
