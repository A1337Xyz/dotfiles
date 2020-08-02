#!/bin/sh
awk -F':' '/cpu MHz/{printf(" %.2f MHz ", $2)} END {printf "\n"}' /proc/cpuinfo

