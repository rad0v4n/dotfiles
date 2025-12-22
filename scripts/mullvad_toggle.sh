#!/usr/bin/env bash

status=$(mullvad status)
if echo "$status" | grep -q "Disconnected"; then
    mullvad connect
else
    mullvad disconnect
fi
