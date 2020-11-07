#!/usr/bin/env bash
lock=/tmp/cGxheWluZ19ub3cuc2gK.lock
[ -f "$lock" ] && exit 1
touch "$lock"
end() { rm -f "$lock" ; exit 0 ; }
trap end EXIT SIGINT SIGTERM
[ -d ~/.cache/albums ] || mkdir ~/.cache/albums
curr_song=
while :;do
    players=($(playerctl -l | grep -v chromium))
    for player in "${players[@]}";do
        [ $(playerctl -p $player status) = Playing ] && break
    done
    [ -z "$player" ] && { sleep 60 ; continue; }
    IFS=';' read -r -a song < <(\
        playerctl --player=$player metadata\
        --format '{{xesam:artist}};{{xesam:title}};{{mpris:length}};{{mpris:artUrl}}'\
    )
    ms=${song[2]}
    s=$((ms / 10**6))
    m=$((s / 60))
    song[2]="$m:$((s % 60))"
    [ "${song[1]}" != "$curr_song" ] && curr_song="${song[1]}" || continue
    if ! [ -f ~/.cache/albums/"${song[3]##*/}" ];then
        if [ -n "${song[3]}" ];then
            #wget -L --content-disposition -P ~/.cache/albums "${song[3]}"
            cd ~/.cache/albums && curl -sO "${song[3]}" 
        fi
    fi
    icon=~/.cache/albums/"${song[3]##*/}"
    if [ $1 = text ];then
        echo "Playing Now ♪ ${song[0]} ${song[1]} ${song[2]}"
        break
    else
        notify-send -i "$icon" -t 7000 "Playing Now ♪" "Artist: ${song[0]}\nTitle: ${song[1]}\nDuration: ${song[2]}"
        sleep 60
    fi
done
