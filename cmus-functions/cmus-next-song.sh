#!/bin/sh
# Dependencies: cmus
if ps -C cmus > /dev/null; then
    cmus-remote -n
fi
