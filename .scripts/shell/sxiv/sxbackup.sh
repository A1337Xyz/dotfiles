#!/bin/sh

sxiv -qato | tr '\n' '\0' | tar czvf "backup_pictures_$(date +%Y%m%d%H).tar.gz" --null -T -
