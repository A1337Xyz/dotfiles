#!/bin/sh

SCRIPT="$0"
DIR=~/Downloads

usage() {
    printf 'Usage: %s -h -i FILE -d DIR file.torrent\n' "$SCRIPT"
    exit 1
}
[ "$#" -eq 0 ] && usage

### PARSE ARGS
torrent=
for i in "$@";do
    [ -f "$i" ] && [ "${i##*.}" = "torrent" ] && torrent="$i"
done
[ -z "$torrent" ] && usage
completed="${torrent}_completed.txt"

### PARSE OPTS 
input=
for i in "$@";do
    case "$i" in
        -i) shift; if [ -s "$1" ];then input="$1" ;else usage; fi ;;
        -d) shift; DIR="$1" ;;
        -h) usage ;;
        *) shift ;;
    esac
done
[ -d "$DIR" ] || { printf '"%s" not found\n' "$DIR"; exit 1; }

### SELECT THE FILES TO BE DOWNLOADED
if [ -z "$input" ];then
    output="${torrent}.txt"
    i=1
    while [ -f "$output" ];do
        output="${torrent}_${i}.txt"
        i=$((i + 1))
    done

    if [ -s "$completed" ];then
        # the following monstrosity, creates this expression '^\(1\|2\|100\|...\)'
        # to only list the files that have not been downloaded
        pattern=$(cut -d'|' -f1 "$completed" | tr \\n ' ' | sed 's/ /\\|/g' | rev | cut -c3- | rev)
        aria2c -S "$torrent" | awk '/[0-9]\|/' | sed 's/^\s*//g' |
            grep -v '^\('"$pattern"'\)|' | fzf -m | sort -n > "$output"
    else
        aria2c -S "$torrent" | awk '/[0-9]\|/' | sed 's/^\s*//g' | fzf -m | sort -n > "$output"
    fi

    [ -s "$output" ] || { rm -vf "$output"; exit 1; }
    input="$output"
fi

tmpfile=$(mktemp)
cp -v "$input" "$tmpfile" # don't read and write the same file.

line=1
while read -r l;do
    clear
    [ -s "$input" ] || { printf '"%s" not found\n' "$input"; break; }
    [ -s "$torrent" ] || { printf '"%s" not found\n' "$torrent"; break; }

    idx="${l%%|*}"
    curr_file=$(sed $line'!d' "$input")
    printf '\e[1;33m>>>\e[m %s\n\n' "$curr_file"
    if aria2c --dir="$DIR" --select-file "$idx" "$torrent";then
        # if there's a "|" in the filename try to use:
        #  sed $line'!d' | rev | cut -d'|' -f2- | rev
        if ! grep -q '^'"$idx"'|' "$completed";then
            printf '%s\n' "$curr_file" >> "$completed"
        fi
        notify-send "Download completed" "$curr_file"
    else
        notify-send -u critical "Download failed!" "$curr_file"
        sleep 1 # sleep so i can ctrl+c this script
    fi
    line=$((line + 1))
done < "$tmpfile"

rm -vf "$tmpfile"
printf "Press ENTER to exit"
timeout 300 sh -c 'read -r' # SC2039: In POSIX sh, read -t is undefined

exit 0
