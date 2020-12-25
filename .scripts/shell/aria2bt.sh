#!/usr/bin/env bash
set -e
command -v aria2c &>/dev/null || { printf 'install aria2\n'; exit 1; }

INCOMPLETE_TORRENTS="${XDG_DOWNLOAD_DIR}/.torrents"
COMPLETE_TORRENTS="${XDG_DOWNLOAD_DIR}"
ERROR_DIR="${INCOMPLETE_TORRENTS}/.error"
TIMEOUT=300

[ -d "$INCOMPLETE_TORRENTS" ] || mkdir -v "$INCOMPLETE_TORRENTS"
[ -d "$ERROR_DIR" ] || mkdir -v "$ERROR_DIR"

torrent="$1"
if [ -f "$torrent" ];then
    du -ad1 "$INCOMPLETE_TORRENTS" | grep -q "$torrent" || {
        mv -vn "$torrent" "$INCOMPLETE_TORRENTS";
        torrent="${INCOMPLETE_TORRENTS}/${torrent##*/}";
    }
else
    notify-send 'torrent added' 'saving metadata...'
    tmpdir=$(mktemp -d)
    printf "saving torrent metadata...\n"
    aria2c -q --bt-stop-timeout=$TIMEOUT --bt-save-metadata --bt-metadata-only -d "$tmpdir" "$torrent" || { rm -rf "$tmpdir" ; exit 1; }

    torrent=$(find "$tmpdir" -type f)
    torrent_name="${INCOMPLETE_TORRENTS}/$(aria2c -S "$torrent" | awk -F':' '/^Name/{print $2}' | sed 's/^\s*//').torrent"
    mv -vf "$torrent" "$torrent_name" && rm -r "$tmpdir"
    torrent="$torrent_name"
fi

TORRENT_NAME=$(aria2c -S "$torrent" | awk -F':' '/^Name/{print $2}' | sed 's/^\s*//')
TORRENT_SIZE=$(aria2c -S "$torrent" | awk '/^Total/{print}')

echo -e '\033]2;'"aria2bt: $TORRENT_NAME"'\007'
notify-send -t 3000 "torrent started" "Name: ${TORRENT_NAME%.*}\n$TORRENT_SIZE"
printf '>>> %s\n>>> %s\n' "$TORRENT_NAME" "$TORRENT_SIZE"

if aria2c --bt-stop-timeout=$TIMEOUT -d "$INCOMPLETE_TORRENTS" "$torrent";then
    clear
    rm -vf "$torrent"
    mv -vn "$INCOMPLETE_TORRENTS/${TORRENT_NAME}" "$COMPLETE_TORRENTS"
    notify-send "torrent completed" "Name: $TORRENT_NAME\n$TORRENT_SIZE"
    exit 0
else
    notify-send "$TORRENT_NAME" "finished with errors"
    mv -vf "$torrent" "$ERROR_DIR"

    exit 1
fi
