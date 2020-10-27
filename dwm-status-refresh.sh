#!/bin/bash
function get_bytes {
	# Find active network interface
	interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
	line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
	eval $line
	now=$(date +%s%N)
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.

function get_velocity {
	value=$1
	old_value=$2
	now=$3

	timediff=$(($now - $old_time))
	velKB=$(echo "1000000000*($value-$old_value)/1000/$timediff" | bc)
	if test "$velKB" -gt 1000
	then
		echo $(echo "scale=2; $velKB/1000" | bc)Mib/s
	else
		echo ${velKB}kib/s
	fi
}

# Get initial values
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

get_time_until_charged() {

	# parses acpitool's battery info for the remaining charge of all batteries and sums them up
	sum_remaining_charge=$(acpitool -B | grep -E 'Remaining capacity' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	# finds the rate at which the batteries being drained at
	present_rate=$(acpitool -B | grep -E 'Present rate' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	seconds=$(bc <<< "scale = 10; ($sum_remaining_charge / $present_rate) * 3600");

	# prettifies the seconds into h:mm:ss format
	pretty_time=$(date -u -d @${seconds} +%T);

	echo $pretty_time;
}

get_battery_combined_percent() {

	total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

	# get amount of batteries in the device
	battery_number=$(acpi -b | wc -l);

	percent=$(expr $total_charge / $battery_number);
    if [ $percent -eq 100 ]; then
        echo "99";
    else
	    echo $percent;
    fi
}

get_battery_charging_status() {
	if $(acpi -b | grep --quiet Discharging)
	then
		echo "🔋";
	else 
        echo "";
	fi
}

print_bat(){
	total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

	# get amount of batteries in the device
	battery_number=$(acpi -b | wc -l);

	percent=$(expr $total_charge / $battery_number);
	if $(acpi -b | grep --quiet Discharging); then
        if [ "$percent" -gt 0 ] && [ "$percent" -le 10 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 10 ] && [ "$percent" -le 20 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 20 ] && [ "$percent" -le 30 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 30 ] && [ "$percent" -le 40 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 40 ] && [ "$percent" -le 50 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 50 ] && [ "$percent" -le 60 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 60 ] && [ "$percent" -le 70 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 70 ] && [ "$percent" -le 80 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 80 ] && [ "$percent" -le 90 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 90 ] && [ "$percent" -le 98 ]; then
            printf "%.f%s" "$percent" "%"
        else
            printf "%.f%s" "$percent" "%"
        fi
	else 
        if [ "$percent" -gt 0 ] && [ "$percent" -le 15 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 15 ] && [ "$percent" -le 30 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 30 ] && [ "$percent" -le 40 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 40 ] && [ "$percent" -le 60 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 60 ] && [ "$percent" -le 80 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 80 ] && [ "$percent" -le 90 ]; then
            printf "%.f%s" "$percent" "%"
        elif [ "$percent" -gt 90 ] && [ "$percent" -le 98 ]; then
            printf "%.f%s" "$percent" "%"
        else
            printf "%.f%s" "$percent" "%"
        fi
    fi

    #echo "$(get_battery_charging_status)$(get_battery_combined_percent)%";
    #echo "$(get_battery_charging_status)$(get_battery_combined_percent)%$(get_time_until_charged)";
}

print_date(){
	date '+%b.%d %H:%M'
}

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

#. "$DIR/dwmbar-functions/dwm_transmission.sh"
#. "$DIR/dwmbar-functions/dwm_cmus.sh"
#. "$DIR/dwmbar-functions/dwm_resources.sh"
#. "$DIR/dwmbar-functions/dwm_battery.sh"
#. "$DIR/dwmbar-functions/dwm_mail.sh"
. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_alsa.sh"
. "$DIR/dwmbar-functions/cpu-thermal.sh"
. "$DIR/dwmbar-functions/dwm_mem-status.sh"
. "$DIR/dwmbar-functions/dwm_cpu-load.sh"

#. "$DIR/dwmbar-functions/dwm_pulse.sh"
#. "$DIR/dwmbar-functions/dwm_weather.sh"
#. "$DIR/dwmbar-functions/dwm_vpn.sh"
#. "$DIR/dwmbar-functions/dwm_network.sh"
#. "$DIR/dwmbar-functions/dwm_keyboard.sh"
#. "$DIR/dwmbar-functions/dwm_ccurse.sh"
#. "$DIR/dwmbar-functions/dwm_date.sh"



get_bytes
# Calculates speeds
vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

xsetroot -name "$(dwm_mem-status) $vel_recv $vel_trans $(dwm_backlight) $(dwm_alsa) $(dwm_cpu-load) $(cpu-thermal) $(print_bat) $(print_date)"

old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

exit 0
