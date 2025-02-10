#!/usr/bin/env bash

set -e

TOUCHPAD_ID=$(xinput --list | grep "Touchpad" | sed -E "s/.*id=([0-9]+).*/\1/")
TOUCHPAD_STATUS=$(xinput list-props $TOUCHPAD_ID | grep "Device Enabled" | sed -E "s/.*:\s([01])/\1/")

if [ $TOUCHPAD_STATUS == 0 ]; then
    xinput enable $TOUCHPAD_ID
    notify-send -t 1000 "Enabled touchpad"
else
    xinput disable $TOUCHPAD_ID
    notify-send -t 1000 "Disabled touchpad"
fi
