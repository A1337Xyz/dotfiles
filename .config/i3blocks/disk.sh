#!/usr/bin/env bash

val=$(df -h /home | awk 'END{print $5}')

echo "HOME $val"
[ "${val%?}" -gt 90 ] && exit 33 
