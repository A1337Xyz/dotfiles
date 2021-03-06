#!/usr/bin/env bash

usage() { printf 'Usage: sxcp.sh <directory>\n'; exit 1; }

for arg in "$@";do
    [ -d "$arg" ] && target="$arg"
    [ "$arg" = "video" ] && opt="video"
done
[ -z "$target" ] && usage

case "$opt" in
    video)
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
        done | sxiv -aipqto 2>/dev/null | while read -r i;do
            fname="${i##*/}"
            fname="${fname%.*}"
            cp -v "$fname" "$target"
        done 
    ;;
    *)
        find . -maxdepth 1 -iregex '.*\.\(jpg\|png\|jpeg\|gif\)' |
            sxiv -iaqto 2>/dev/null | while read -r i;do cp -v "$i" "$target" ;done
    ;;
esac
