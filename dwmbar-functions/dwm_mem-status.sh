#! /bin/bash

dwm_mem-status () {
    mem_use_info=(`awk '/MemTotal/{memtotal=$2}/MemAvailable/{memavailable=$2}END{printf "%.2f %.2f %.2f",memtotal/1024/1024," "(memtotal-memavailable)/1024/1024," "(memtotal-memavailable)/memtotal*100}' /proc/meminfo`)
    #echo total:${mem_use_info[0]}G  used:${mem_use_info[1]}G  Usage:${mem_use_info[2]}%
    MEMUSED=${mem_use_info[1]}

    if [ $(echo "$MEMUSED > 0" | bc) = 1 ] && [ $(echo "$MEMUSED < 3.50" | bc) = 1 ]; then
        printf ""
    elif [ $(echo "$MEMUSED >= 3.50" | bc) = 1 ] && [ $(echo "$MEMUSED < 6.50" | bc) = 1 ]; then
        printf "Mod"
    elif [ $(echo "$MEMUSED >= 6.50" | bc) = 1 ] && [ $(echo "$MEMUSED < 8.00" | bc) = 1 ]; then
        printf "ﲍHeavy"
    fi
}
