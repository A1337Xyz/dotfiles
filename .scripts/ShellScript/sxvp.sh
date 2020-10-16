#!/usr/bin/env bash

dependencies=(sxiv ffmpegthumbnailer mpv)
for dep in "${dependencies[@]}";do
    command -v "$dep" >/dev/null || { printf 'install %s\n' "$dep"; exit 1; }
done

tmpdir=$(mktemp -d)
find . -maxdepth 1 -iregex '.*\(mp4\|mkv\|webm\|avi\)' -type f | while read -r i;do
    out="$tmpdir"/"${i##*/}".jpg
    ffmpegthumbnailer -s 300 -i "$i" -q 10 -o "$out" 2>/dev/null
    printf '%s\n' "$out"
done | sxiv -aipqto 2>/dev/null | while read -r i;do
    fname="${i##*/}"
    fname="${fname%.*}"
    printf '%s\0' "$fname"
done | xargs -r0I{} mpv --no-audio {}
rm -rf "$tmpdir"
