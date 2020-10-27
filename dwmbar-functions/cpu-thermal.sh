# !/bin/bash

cpu-thermal(){
temp=$(cat /sys/class/thermal/thermal_zone6/temp)
echo $(echo "$temp/1000" |bc)
}
