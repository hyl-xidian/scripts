#!/bin/bash

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

. "$DIR/dwmbar-functions/dwm_alsa.sh"
. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_cpu-thermal.sh"
. "$DIR/dwmbar-functions/dwm_mem-status.sh"
. "$DIR/dwmbar-functions/dwm_cpu-load.sh"
. "$DIR/dwmbar-functions/dwm_netspead.sh"
. "$DIR/dwmbar-functions/dwm_battery.sh"
. "$DIR/dwmbar-functions/dwm_date.sh"

xsetroot -name "$(dwm_mem-status) $(dwm_netspead) $(dwm_backlight) $(dwm_alsa) $(dwm_cpu-load) $(dwm_cpu-thermal) $(print_bat) $(dwm_date)"

exit 0
