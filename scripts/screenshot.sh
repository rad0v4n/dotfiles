#!/usr/bin/env bash
source "/home/user/scripts/configs/slurp.conf"

killall grim 2>/dev/null
killall slurp 2>/dev/null
grim -g "$(slurp -b '#00000080' -c "$primary" -w 2)" - | wl-copy
