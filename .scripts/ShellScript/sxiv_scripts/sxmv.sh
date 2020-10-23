#!/usr/bin/env bash

usage() { printf 'Usage: sxmv.sh <directory>\n'; exit 1; }

[ -z "$1" ] && usage
[ -d "$1" ] || usage

cache_dir=~/.cache/sxiv_scripts
[ -d "$cache_dir" ] || mkdir -v "$cache_dir"
cache="${cache_dir}/files"
[ -f "$cache" ] || touch "$cache"

find . -maxdepth 1 -iregex '.*\(mp4\|mkv\|webm\|avi\|jpg\|png\|gif\|jpeg\)' -type f | while read -r i;do
    case "${i##*.}" in
        mp4|mkv|webm|avi)
            file_size=$(command du "$i")
            out="${cache_dir}/${i##*/}.jpg"
            if ! grep -qF "$file_size" "$cache";then
                ffmpegthumbnailer -s 300 -i "$i" -q 10 -o "$out" 2>/dev/null
                echo "$file_size" >> "$cache"
            fi
        ;;
    esac 
    echo "$out"
done | sxiv -aipqto 2>/dev/null | while read -r i;do
    fname="${i##*/}"
    fname="${fname%.*}"
    mv -vn "$fname" "$1"
done 
