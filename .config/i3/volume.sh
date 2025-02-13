#!/usr/bin/env bash

set -e

volume_raise() {
    wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    pkill -SIGRTMIN+1 i3blocks
}

volume_lower() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    pkill -SIGRTMIN+1 i3blocks
}

volume_toggle() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    pkill -SIGRTMIN+1 i3blocks
}

mic_toggle() {
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    pkill -SIGRTMIN+2 i3blocks
}

$@
