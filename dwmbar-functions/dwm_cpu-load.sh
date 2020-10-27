#!/bin/sh

dwm_cpu-load () {
    #CPUUSED=$(top -n 1 | awk '/Cpu/{print $2}')
    #CPUUSED=$(top -n 1 |grep Cpu | cut -d "," -f 1 | cut -d ":" -f 2 | cut -d " " -f 3);
    LOAD=$(cat /proc/loadavg | awk '{print $1}');
    PROCESSOR_NUM=$(cat /proc/cpuinfo| grep "processor"| wc -l);
    LOAD_PERCENT=$(echo "scale=6;$LOAD/$PROCESSOR_NUM/0.75*100" |bc)
    #printf "CPU %.f%s" "$LOAD" "%";
    printf "%.1f%s" "$LOAD_PERCENT" "%"
}
