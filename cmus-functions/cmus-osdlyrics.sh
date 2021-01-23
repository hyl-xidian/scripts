#!/bin/sh
if ps -C osdlyrics > /dev/null; then
    killall osdlyrics
else
    osdlyrics
fi
