#!/usr/bin/env bash
LINES=15
case "${1##*.}" in
    jpg|jpeg|png|gif|mp4|mkv|avi|webm|mp3|flac) mediainfo "$1" ;;
    a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
    rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip) atool --list -- "$1" ;;
    rar) unrar lt -p- -- "$1" ;;
    7z) 7z l -p -- "$1" ;;
    pdf) pdftotext -l 10 -nopgbrk -q -- "$1" - ;;
    torrent) aria2c -S "$1"  ;;
    odt|ods|odp|sxw) odt2txt "$1" ;;
    htm|html|xhtml) w3m -dump "$1" ;;
    *) highlight "$1" -O ansi --force ;;
esac
