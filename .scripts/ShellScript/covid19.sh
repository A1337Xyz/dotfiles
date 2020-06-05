#!/bin/sh
curl -sS https:/corona-stats.online/br |
    sed -r 's/\s*//g ; s/│/;/g ; s/\x1b\[[0-9;]*m//g' | 
    awk -F';' '/Brazil/{printf("Confirmed: %s\nDeaths: %s\nRecovered: %s\n", $3, $5, $4, $5)}' |
    xargs -0I{} notify-send -t 5000 "Covid19 - $(date +%H:%M' '%d/%m/%y)" {} &
