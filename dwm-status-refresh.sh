#!/bin/bash

print_mem(){
	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	echo -e "$memfree"
}

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

	echo $percent;
}

get_battery_charging_status() {

	if $(acpi -b | grep --quiet Discharging)
	then
		echo "🔋";
	else 
		echo "🔌";
	fi
}

print_bat(){
	echo "$(get_battery_charging_status)$(get_battery_combined_percent)%";
	#echo "$(get_battery_charging_status)$(get_battery_combined_percent)%$(get_time_until_charged)";
}

print_date(){
	date '+%Y年%m月%d日 %H:%M'
}

show_record(){
	test -f /tmp/r2d2 || return
	rp=$(cat /tmp/r2d2 | awk '{print $2}')
	size=$(du -h $rp | awk '{print $1}')
	echo " $size $(basename $rp)"
}

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

#. "$DIR/dwmbar-functions/dwm_transmission.sh"
#. "$DIR/dwmbar-functions/dwm_cmus.sh"
. "$DIR/dwmbar-functions/dwm_resources.sh"
#. "$DIR/dwmbar-functions/dwm_battery.sh"
#. "$DIR/dwmbar-functions/dwm_mail.sh"
#. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_alsa.sh"
#. "$DIR/dwmbar-functions/dwm_pulse.sh"
#. "$DIR/dwmbar-functions/dwm_weather.sh"
#. "$DIR/dwmbar-functions/dwm_vpn.sh"
#. "$DIR/dwmbar-functions/dwm_network.sh"
#. "$DIR/dwmbar-functions/dwm_keyboard.sh"
#. "$DIR/dwmbar-functions/dwm_ccurse.sh"
#. "$DIR/dwmbar-functions/dwm_date.sh"

xsetroot -name "$(dwm_resources)|$(dwm_alsa)|$(print_bat)|$(show_record) $(print_date)"

exit 0
