#!/usr/bin/env bash

dependencies=(sxiv ffmpegthumbnailer mpv)
for dep in "${dependencies[@]}";do
    command -v "$dep" >/dev/null || { printf 'install %s\n' "$dep"; exit 1; }
done

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
