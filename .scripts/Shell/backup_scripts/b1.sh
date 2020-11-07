#!/usr/bin/env bash
BKP_LIST="${HOME}/.scripts/ShellScript/backup_scripts/backup_list.txt"
if [[ ! -a "$BKP_LIST" ]];then
    printf '# use $HOME environment variable or the absolute path to specify the files\n# do not use ~' >>  "$BKP_LIST"
    [ -z "$EDITOR" ] && EDITOR="nano"
    $EDITOR "$BKP_LIST"
    exit 0
fi
BKPS_FOLDER="${HOME}/.backups"
[ -d "${BKPS_FOLDER}" ] || mkdir -v "${BKPS_FOLDER}" || exit 1
BKP="${BKPS_FOLDER}/backup_$(date +%Y%m%d%H).tar.lzma"
trap '{ rm -v "$BKP"; exit 1; }' SIGINT
tar -pvc --lzma -f "$BKP" --exclude='*__*__*' $(awk '!/^#/{print}' "$BKP_LIST" | envsubst) 2> /dev/null
trap - SIGINT
du -sh "$BKP"
