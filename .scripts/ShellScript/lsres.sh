#!/bin/sh
find . -maxdepth 1 -iregex '.*\.\(mp4\|mkv\|avi\|webm\)' | while read -r i;do
    mediainfo --Output="Video;%Width%x%Height% : $i" "$i"
done

