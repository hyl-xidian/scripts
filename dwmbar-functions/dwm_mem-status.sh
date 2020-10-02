#! /bin/sh

dwm_mem-status () {
    MEMUSED=$(free -m | awk '(NR == 2) {print $3}' | cut -d " " -f 1)
    printf "%s" "$SEP1"
    if [ "$MEMUSED" -gt 0 ] && [ "$MEMUSED" -le 3000 ]; then
        printf ""
    elif [ "$MEMUSED" -gt 3000 ] &&[ "$MEMUSED" -le 7500 ]; then
        printf "💿Moderate"
    elif [ "$MEMUSED" -gt 7500 ] && [ "$MEMUSED" -le 12800 ]; then
        printf "💿Heavy"
    else
        printf "⚠ MEM WARNING!!!"
    fi
    printf "%s" "$SEP2"
}
