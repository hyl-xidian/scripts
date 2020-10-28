#!/bin/bash

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

. "$DIR/dwmbar-functions/dwm_mail.sh"
. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_alsa.sh"
. "$DIR/dwmbar-functions/dwm_cpu-thermal.sh"
. "$DIR/dwmbar-functions/dwm_mem-status.sh"
. "$DIR/dwmbar-functions/dwm_cpu-load.sh"
. "$DIR/dwmbar-functions/dwm_netspead.sh"
. "$DIR/dwmbar-functions/dwm_battery.sh"
. "$DIR/dwmbar-functions/dwm_date.sh"

#. "$DIR/dwmbar-functions/dwm_transmission.sh"
#. "$DIR/dwmbar-functions/dwm_cmus.sh"
#. "$DIR/dwmbar-functions/dwm_resources.sh"
#. "$DIR/dwmbar-functions/dwm_pulse.sh"
#. "$DIR/dwmbar-functions/dwm_vpn.sh"
#. "$DIR/dwmbar-functions/dwm_network.sh"
#. "$DIR/dwmbar-functions/dwm_keyboard.sh"
#. "$DIR/dwmbar-functions/dwm_ccurse.sh"

# Get initial values
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

# Get update values
get_bytes
# Calculates speeds
vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

xsetroot -name "$(dwm_mem-status) $vel_recv $vel_trans $(dwm_backlight) $(dwm_alsa) $(dwm_cpu-load) $(dwm_cpu-thermal) $(print_bat) $(dwm_date)"

old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

exit 0
