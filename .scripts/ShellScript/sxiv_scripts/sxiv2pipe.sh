#!/usr/bin/env bash
set -e
_sxiv='/usr/bin/sxiv -qato'

case $1 in
    --backup) $_sxiv . | tr '\n' '\0' | tar czvf "backup_pictures_$(date +%Y%m%d%H).tar.gz" --null -T - ;;
    --bg) $_sxiv "$PWD" | xargs -r xwall.sh ;;
esac
