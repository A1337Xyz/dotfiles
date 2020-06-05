#!/usr/bin/env bash
output="${1%.*}.gif"
c=1
while [ -a "$output" ];do
    output="${c}_${1%.*}.gif"
    c=$((c+1))
done
printf '%s \e[1;32m~\e[1;37m>\e[m %s\n' "$1" "$output"

ffmpeg -hide_banner -nostdin -v -16 -i "$1" \
    -filter_complex 'split[a][b];[a]palettegen[p];[b][p]paletteuse' "$output"

[ $? -ne 0 ] && { rm -v "$output" 2>/dev/null; exit 1; }
exit 0
