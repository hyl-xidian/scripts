#!/bin/sh

dwm_cpu-load () {
    CPUUSED=$(top -n 1 | awk '/Cpu/{print $2}')
    #CPUUSED=$(top -n 1 |grep Cpu | cut -d "," -f 1 | cut -d ":" -f 2 | cut -d " " -f 3);
    #LOAD=$(cat /proc/loadavg | awk '{print $1}');
    #printf "CPU %.f%s" "$LOAD" "%";
    echo $CPUUSED;
}
