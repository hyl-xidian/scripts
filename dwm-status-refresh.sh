#!/bin/bash

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

. "$DIR/dwmbar-functions/dwm_alsa.sh"
. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_cpu-usage_netspeed.sh"
. "$DIR/dwmbar-functions/dwm_cpu-thermal.sh"
. "$DIR/dwmbar-functions/dwm_mem-status.sh"
. "$DIR/dwmbar-functions/dwm_battery.sh"
. "$DIR/dwmbar-functions/dwm_date.sh"
. "$DIR/dwmbar-functions/dwm_date_simple.sh"
#. "$DIR/dwmbar-functions/dwm_cpu-load.sh"

. "$DIR/dwmbar-functions/dwm_cmus.sh"

#xsetroot -name "$(dwm_mem-status) $(dwm_cmus) $(dwm_cpu-usage_netspeed) $(dwm_cpu-thermal) $(dwm_backlight) $(dwm_alsa) $(print_bat) $(dwm_date)"

# simplify
#1
#xsetroot -name "$(dwm_mem-status) $(dwm_cmus) $(dwm_cpu-usage_netspeed) $(dwm_alsa) $(dwm_date_simple)"
#2
#xsetroot -name "$(dwm_cmus) $(dwm_cpu-usage_netspeed) $(dwm_alsa) $(dwm_date_simple)"
#3
xsetroot -name "$(dwm_cmus) $(dwm_cpu-usage_netspeed) $(dwm_alsa) $(print_bat) $(dwm_date_simple)"

exit 0
