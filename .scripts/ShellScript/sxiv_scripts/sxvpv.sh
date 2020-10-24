#!/usr/bin/env bash

cache_dir=~/.cache/sxiv_scripts
[ -d "$cache_dir" ] || mkdir -v "$cache_dir"
cache="${cache_dir}/files2"
[ -f "$cache" ] || touch "$cache"

declare -A files=()

while read -r i;do
    target=$(find "$i" -maxdepth 1 -iregex '.*\.\(mp4\|mkv\|webm\|avi\)$' | sort | head -n1)
    if [ -n "$target" ];then
        file_size=$(command du "$target")
        out="${cache_dir}/${target##*/}.jpg"
        files["$out"]="$i"
        if ! grep -qF "$file_size" "$cache";then
            ffmpegthumbnailer -f -s 300 -i "$target" -q 10 -o "$out" 2>/dev/null
            echo "$file_size" >> "$cache"
        fi
    fi
done < <(find . -maxdepth 1 -type d)

for k in "${!files[@]}";do echo "$k" ;done | sxiv -qito 2>/dev/null | while read -r k;do
    echo -n "${files[$k]}"
done | xargs -r0 mpv 

