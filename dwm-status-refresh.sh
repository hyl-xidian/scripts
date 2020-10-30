#!/bin/bash

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

. "$DIR/dwmbar-functions/dwm_alsa.sh"
. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_cpu-usage_netspeed.sh"
. "$DIR/dwmbar-functions/dwm_cpu-thermal.sh"
. "$DIR/dwmbar-functions/dwm_mem-status.sh"
. "$DIR/dwmbar-functions/dwm_netspeed.sh"
. "$DIR/dwmbar-functions/dwm_battery.sh"
. "$DIR/dwmbar-functions/dwm_date.sh"
#. "$DIR/dwmbar-functions/dwm_cpu-load.sh"

xsetroot -name "$(dwm_mem-status) $(dwm_cpu-usage_netspeed) $(dwm_cpu-thermal) $(dwm_backlight) $(dwm_alsa) $(print_bat) $(dwm_date)"

exit 0
