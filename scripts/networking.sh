#!/usr/bin/env bash

status=$(nmcli -t -f CONNECTIVITY networking connectivity 2>/dev/null)

case "$status" in
  full)
    notify-send "Turning networking off." -i action-unavailable-symbolic -a dms
    nmcli networking off
    ;;
  none)
    notify-send "Turning networking on." -i network-wireless-symbolic -a dms
    nmcli networking on
    ;;
  *)
    echo "Connectivity status is '$status'. No action taken."
    ;;
esac
