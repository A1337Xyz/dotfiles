#!/bin/sh
for i in {3..1};do echo -n "$i..." ; sleep 1 ;done && notify-send "Recording now"

ffmpeg -hide_banner -v 32 -y -video_size 1366x768 -r 25 -f x11grab -i :0 -f pulse -ac 2 -i default \
    -c:v h264 -crf 18 -profile:v baseline -pix_fmt yuv420p \
    -preset ultrafast -tune zerolatency -threads 0 record_$(date +%d%m%Y%H%M).mp4
