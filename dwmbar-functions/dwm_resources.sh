#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
    MEMTOT=$(free -h |awk '(NR == 2) {print $2}')

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "💻 MEM %s/%s|" "$MEMUSED" "$MEMTOT"
    else
        printf "STA | MEM %s/%s" "$MEMUSED" "$MEMTOT"
    fi
    printf "%s\n" "$SEP2"
}

dwm_resources
