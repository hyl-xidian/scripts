#!/bin/sh
# Dependencies: cmus
if ps -C cmus > /dev/null; then
    VOL=$(cmus-remote -Q | grep -a '^set vol_left' | awk '{gsub("set vol_left ", "");print}')
    VOL_UP=$(echo "$VOL+15"|bc)
    cmus-remote -v $VOL_UP%
    notify-send 'Cmus' "The VOL: $VOL_UP%"
fi
