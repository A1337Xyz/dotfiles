#!/bin/sh
sxiv -qarto "$1" | while read -r i;do rm -v "$i" ;done
