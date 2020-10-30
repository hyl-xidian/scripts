#!/bin/sh

dwm_cpu-load () {
    LOAD=$(cat /proc/loadavg | awk '{print $1}');
    PROCESSOR_NUM=$(cat /proc/cpuinfo| grep "processor"| wc -l);
    LOAD_PERCENT=$(echo "scale=6;$LOAD/$PROCESSOR_NUM/0.75*100" |bc)
    #printf "CPU %.f%s" "$LOAD" "%";
    printf "%.1f%s" "$LOAD_PERCENT" "%"
}
