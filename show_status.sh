#!/bin/bash

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

. "$DIR/dwmbar-functions/dwm_alsa.sh"
. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_cpu-thermal.sh"
. "$DIR/dwmbar-functions/dwm_mem_info.sh"
. "$DIR/dwmbar-functions/dwm_battery.sh"
. "$DIR/dwmbar-functions/dwm_date.sh"

echo "$(dwm_mem_info) 
$(dwm_cpu-thermal) $(dwm_backlight) $(dwm_alsa) $(print_bat) 
$(dwm_date)"

exit 0
