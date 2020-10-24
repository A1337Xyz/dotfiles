#!/bin/sh

find . -maxdepth 1 -type d | while read -r i;do
    find "$i" -maxdepth 1 -iregex '.*\(jpg\|png\|gif\|jpeg\)' | sort | head -n1
done | sxiv -qito 2>/dev/null | cut -d'/' -f2 | xargs -rI{} sxiv -qr {} &>/dev/null
