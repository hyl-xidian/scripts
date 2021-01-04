#!/bin/sh
# Dependencies: cmus
if ps -C cmus > /dev/null; then
    STATUS=$(cmus-remote -Q | grep -a '^status' | awk '{gsub("status ", "");print}')
    if [ "$STATUS" = "playing" ]; then
        cmus-remote -u
    else
        cmus-remote -p
    fi
else
    st /bin/bash cmus
fi
