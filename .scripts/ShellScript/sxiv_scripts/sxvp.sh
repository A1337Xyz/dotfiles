#!/usr/bin/env bash

cache_dir=~/.cache/sxiv_scripts
[ -d "$cache_dir" ] || mkdir -v "$cache_dir"
cache="${cache_dir}/files"
[ -f "$cache" ] || touch "$cache"

find . -maxdepth 1 -iregex '.*\(mp4\|mkv\|webm\|avi\)' -type f | while read -r i;do
    file_size=$(command du "$i")
    out="${cache_dir}/${i##*/}.jpg"
    if ! grep -qF "$file_size" "$cache";then
        ffmpegthumbnailer -s 300 -i "$i" -q 10 -o "$out" 2>/dev/null
        echo "$file_size" >> "$cache"
    fi
    echo "$out"
done | sxiv -ipqto 2>/dev/null | while read -r i;do
    fname="${i##*/}"
    fname="${fname%.*}"
    printf '%s\0' "$fname"
done | xargs -r0 mpv
