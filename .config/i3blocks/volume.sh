#!/bin/bash

VOLUME_STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
VOLUME_VALUE=$(echo $VOLUME_STATUS | awk '{print int($2 * 100)}')

if [[ $VOLUME_STATUS == *"[MUTED]"* || $VOLUME_VALUE == 0 ]]; then
    echo "󰝟 "
    echo
    echo "#f38ba8"
else
    echo "󰕾 $VOLUME_VALUE%"
    echo
    echo "#89b4fa"
fi

exit 0
