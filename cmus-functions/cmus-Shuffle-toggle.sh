#!/bin/sh
# Dependencies: cmus
if ps -C cmus > /dev/null; then
    cmus-remote -S
    SHUFFLE=$(cmus-remote -Q | grep -a '^set shuffle' | awk '{gsub("set shuffle ", "");print}')
    if [ "$SHUFFLE" = "true" ]; then
        SHUFFLE="Shuffle Playback"
    else
        SHUFFLE="Play in order"
    fi
    notify-send 'Cmus' "$SHUFFLE"
fi
