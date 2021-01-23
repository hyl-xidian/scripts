#!/bin/bash
dwm_date () {
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf " %s" "$(date "+%b.%d %A %H:%M")"
    else
        printf "DAT %s" "$(date "+%b.%d %A %H:%M")"
    fi
}

