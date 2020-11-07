#!/bin/sh
awk -F':' '/cpu MHz/{printf(" %.0f MHz", $2)} END {printf "\n"}' /proc/cpuinfo | cut -c2-

