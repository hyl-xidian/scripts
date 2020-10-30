# !/bin/bash

dwm_cpu-thermal(){
temp=$(cat /sys/class/thermal/thermal_zone0/temp)
echo $(echo "$temp/1000" |bc)
}
