#!/usr/bin/env bash
output="${HOME}/.backups/backup_$(date +%Y%m%d%H).tar.lzma"
[ -d ~/.backups ] || mkdir -v ~/.backups
trap '{ rm -v "$output" 2>/dev/null; exit 1; }' 2
find ~/.scripts ! -path "*__*__*" \
    -iregex '.*\.\(py\|sh\)' -print0 | tar --lzma -pcf "$output" --null -T - 2>/dev/null
du -sh "$output"
