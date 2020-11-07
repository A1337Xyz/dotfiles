#!/bin/sh
for i in {5..1};do printf '%d\r' "$i" ; sleep 1 ;done && notify-send "recording now"
ffmpeg -hide_banner -v 32 -video_size 1360x764 -r 25 -f x11grab -i :0+1024 \
    -c:v h264 -crf 21 -profile:v baseline -pix_fmt yuv420p \
    -preset ultrafast -tune zerolatency -threads 0 out.mp4
