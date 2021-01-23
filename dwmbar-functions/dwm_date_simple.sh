#!/bin/bash
dwm_date_simple () {
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "%s" "$(date "+%H:%M")"
    else
        printf "DAT %s" "$(date "+%H:%M")"
    fi
}
