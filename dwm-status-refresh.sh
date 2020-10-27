#!/bin/bash
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

. "$DIR/dwmbar-functions/dwm_mem-status.sh"
#. "$DIR/dwmbar-functions/dwm_cpu-load.sh"

#. "$DIR/dwmbar-functions/dwm_pulse.sh"
#. "$DIR/dwmbar-functions/dwm_weather.sh"
#. "$DIR/dwmbar-functions/dwm_vpn.sh"
#. "$DIR/dwmbar-functions/dwm_network.sh"
#. "$DIR/dwmbar-functions/dwm_keyboard.sh"
#. "$DIR/dwmbar-functions/dwm_ccurse.sh"
#. "$DIR/dwmbar-functions/dwm_date.sh"

xsetroot -name "$(dwm_mem-status)$(dwm_backlight) $(dwm_alsa) $(print_bat) $(print_date)"

exit 0
