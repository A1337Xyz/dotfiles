#!/usr/bin/env bash

command -v sxiv || { printf 'install sxiv\n'; exit 1; }
command -v ffmpegthumbnailer || { printf 'install ffmpegthumbnailer\n'; exit 1; }
command -v mpv || { printf 'install mpv\n'; exit 1; }

CACHE=~/.cache/.video_preview
[ -d "$CACHE" ] || mkdir -v "$CACHE"

declare -A videos
while read -r i;do
    file_hash=$(md5sum "$i" | awk '{print $1}')
    videos[$file_hash]="$i"
done < <(find . -maxdepth 1 -iregex '.*\(mp4\|mkv\|webm\|avi\)' -type f)

for k in "${!videos[@]}";do
    fname="$CACHE"/"$k".jpg
    [ -f "$fname" ] || ffmpegthumbnailer -i "${videos[$k]}" -q 10 -o "$fname"
    printf '%s\n' "$fname"
done | sxiv -aiqto 2>/dev/null | while read -r i;do
    key="${i##*/}"
    key="${key%.*}"
    echo "${videos[$key]}"
done | xargs -I{} mpv --no-audio {}
