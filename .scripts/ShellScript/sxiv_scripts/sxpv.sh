#!/usr/bin/env bash

case "$1" in
    video)
        cache_dir=~/.cache/sxiv_scripts
        [ -d "$cache_dir" ] || mkdir -v "$cache_dir"
        cache="${cache_dir}/files2"
        [ -f "$cache" ] || touch "$cache"

        declare -A files=()

        while read -r i;do
            target=$(find "$i" -maxdepth 1 -iregex '.*\.\(mp4\|mkv\|webm\|avi\)$' | head -n1)
            if [ -n "$target" ];then
                file_size=$(command du "$target")
                out="${cache_dir}/${target##*/}.jpg"
                files["$out"]="$i"
                if ! grep -qF "$file_size" "$cache";then
                    ffmpegthumbnailer -f -s 300 -i "$target" -q 10 -o "$out" 2>/dev/null
                    echo "$file_size" >> "$cache"
                fi
            fi
        done < <(find . -mindepth 1 -maxdepth 1 -type d)

        for k in "${!files[@]}";do echo "$k" ;done | sort | sxiv -qito 2>/dev/null | while read -r k;do
            echo -n "${files[$k]}"
            echo -n "${files[$k]} $k" >> ~/test.txt
        done | xargs -r0 mpv 
    ;;
    *)
        find . -maxdepth 1 -type d | sort | while read -r i;do
            find "$i" -maxdepth 1 -iregex '.*\(jpg\|png\|gif\|jpeg\)' | sort | head -n1
        done | sxiv -qito 2>/dev/null | cut -d'/' -f2 | xargs -rI{} sxiv -qr {} &>/dev/null
    ;;
esac
