#!/usr/bin/env bash

PSNDL_DB=~/.scripts/ShellScript/psndl.net/db

main() {
    declare -A pkgs
    printf 'Reading db, please wait... '
    while read -r l;do
        IFS=';' read -r -a arr < <(printf '%s' "$l")
        title="${arr[1]}"
        category="${arr[2]}"
        country="${arr[3]}"
        url="${arr[4]}"
        [ "$country" = "US" ] && pkgs["$title"]="$category;$url"
    done < <(awk -F';' '$3 == "'"$1"'" {print}' "$PSNDL_DB")
    printf 'done\n'
    title="$(for k in "${!pkgs[@]}";do echo "$k"; done | fzf)"
    [ -z "$title" ] && exit 1
    IFS=';' read -r -a arr < <(echo "${pkgs[$title]}")
    _path=~/Downloads/"$title"
    [ -d "$_path" ] || mkdir -v "$_path"
    aria2c -m 0 -x 8 -d "$_path" --retry-wait=5 "${arr[1]}"
    notify-send "psndl.sh" "Download completed: $title"
}

case $1 in
    avatar) main Avatar ;;
    c00) main C00 ;;
    demo) main Demo ;;
    dlc) main DLC ;;
    edat) main EDAT ;;
    mini) main Mini ;;
    ps1) main PS1 ;;
    ps2) main PS2 ;;
    ps4) main PS4 ;;
    psn) main PSN ;;
    psp) main PSP ;;
    psvita) main PSVita ;;
    soundtrack) main Soundtrack ;;
    theme) main Theme ;;
    update) main Update ;;
    video) main Video ;;
    wallpaper) main Wallpaper ;;
    -h|--help)
        printf '%s [option]\n' "$(basename $0)"
        awk -F';' '{print "\t  "tolower($3)}' "$PSNDL_DB" | sort | uniq
        ;;
    *) main PSN ;;
esac
