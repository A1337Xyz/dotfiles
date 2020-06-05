#!/usr/bin/env bash
curl -s "$1" | grep -oP '(?<=\<a class="downloadlink" href=")http?.*[0-9](?=")' | while read -r l;do
    wget -nv --content-disposition "$l"
done
