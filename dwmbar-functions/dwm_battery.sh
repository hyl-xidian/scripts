#!/bin/bash

get_time_until_charged() {

	# parses acpitool's battery info for the remaining charge of all batteries and sums them up
	sum_remaining_charge=$(acpitool -B | grep -E 'Remaining capacity' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	# finds the rate at which the batteries being drained at
	present_rate=$(acpitool -B | grep -E 'Present rate' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	seconds=$(bc <<< "scale = 10; ($sum_remaining_charge / $present_rate) * 3600");

	# prettifies the seconds into h:mm format
	pretty_time=$(date -u -d @${seconds} +%R);

	echo $pretty_time;
}

print_bat(){
	total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));
	# get amount of batteries in the device
	battery_number=$(acpi -b | wc -l);
	percent=$(expr $total_charge / $battery_number);

	if $(acpi -b | grep --quiet Discharging); then
        if [ "$percent" -gt 0 ] && [ "$percent" -le 10 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 10 ] && [ "$percent" -le 20 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 20 ] && [ "$percent" -le 30 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 30 ] && [ "$percent" -le 40 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 40 ] && [ "$percent" -le 50 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 50 ] && [ "$percent" -le 60 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 60 ] && [ "$percent" -le 70 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 70 ] && [ "$percent" -le 80 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 80 ] && [ "$percent" -le 90 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        elif [ "$percent" -gt 90 ] && [ "$percent" -le 98 ]; then
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        else
            printf "%d%s|%s$" "$percent" "%" "$(get_time_until_charged)"
        fi
	else
        if [ "$percent" -gt 0 ] && [ "$percent" -le 15 ]; then
            printf "%d%s" "$percent" "%"
        elif [ "$percent" -gt 15 ] && [ "$percent" -le 30 ]; then
            printf "%d%s" "$percent" "%"
        elif [ "$percent" -gt 30 ] && [ "$percent" -le 40 ]; then
            printf "%d%s" "$percent" "%"
        elif [ "$percent" -gt 40 ] && [ "$percent" -le 60 ]; then
            printf "%d%s" "$percent" "%"
        elif [ "$percent" -gt 60 ] && [ "$percent" -le 80 ]; then
            printf "%d%s" "$percent" "%"
        elif [ "$percent" -gt 80 ] && [ "$percent" -le 90 ]; then
            printf "%d%s" "$percent" "%"
        elif [ "$percent" -gt 90 ] && [ "$percent" -le 98 ]; then
            printf "%d%s" "$percent" "%"
        else
            printf "%d%s" "99" "%"
        fi
    fi
    #echo "$(get_battery_charging_status)$(get_battery_combined_percent)%$(get_time_until_charged)";
}


