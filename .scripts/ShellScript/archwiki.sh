#!/usr/bin/env bash

history_search=~/.cache/.archwiki_history_search

[ -f "$history_search" ] || touch "$history_search"
search=$(cat "$history_search" | dmenu -p "ArchWiki" -i -l 10)
grep -qi "$search" "$history_search" 2>/dev/null || echo "$search" >> "$history_search"
$BROWSER "https://wiki.archlinux.org/index.php?search=${search}" 2>/dev/null
