#!/usr/bin/env bash
val=$(free | awk '/Mem/{print ($3*100)/$2}')
printf 'MEM %.0f%%\n' "$val"

[ "${val%.*}" -gt 80 ] && exit 33
