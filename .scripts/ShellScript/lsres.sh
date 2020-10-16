#!/bin/sh
find . -maxdepth 1 -iregex '.*\.\(mp4\|mkv\|avi\|webm\|jpg\|png\|jpeg\)' | while read -r i;do
    case ${i##*.} in
        jpg|png|jpeg) mediainfo --Output="Image;%Width%x%Height% : $i" "$i" ;;
        *) mediainfo --Output="Video;%Width%x%Height% : $i" "$i" ;;
    esac
done | sed '/^\s*$/d'

