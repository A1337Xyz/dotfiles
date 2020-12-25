#!/usr/bin/env bash
xwall.sh "$(sxiv -qto "${1-.}" 2>/dev/null)"
