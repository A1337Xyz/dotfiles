#!/usr/bin/env bash
set -e
_sxiv='/usr/bin/sxiv -qato'

case $1 in
    --rm) $_sxiv . | while read -r i;do rm -v "$i" ;done ;;
    --mv)
        [ -d "$2" ] || exit 1
        [ "${2: -1}" = "/" ] && target="${2::-1}" || target="$2"
        $_sxiv . | while read -r i;do
            if [ -f "$target/$i" ];then
                mv -vn "$i" "$target/$((RANDOM**2)).${i##*.}"
            else
                mv -vn "$i" "$target"
            fi
        done ;;
    --backup) $_sxiv . | tr '\n' '\0' | tar czvf "backup_pictures_$(date +%Y%m%d%H).tar.gz" --null -T - ;;
    --bg) $_sxiv "$PWD" | xargs -r xwall.sh ;;
    *) printf "Usage: %s --rm|--mv|--backup|--bg\n" "$(basename "$0")"; exit 1 ;;
esac
