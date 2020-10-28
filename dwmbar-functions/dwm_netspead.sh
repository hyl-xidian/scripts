# !/bin/bash

function get_bytes {
	# Find active network interface
	interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
	line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
	eval $line
	now=$(date +%s%N)
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in kbyte per second when greater or equal than 1 kbyte per second.
# This function should be called each second.

function get_velocity {
	value=$1
	old_value=$2
	now=$3

	timediff=$(($now - $old_time))
	velkb=$(echo "1000000000*($value-$old_value)/1000/$timediff" | bc)
	if test "$velkb" -gt 1000
	then
		echo $(echo "scale=2; $velkb/1000" | bc)Mb
	else
		echo ${velkb}kb
	fi
}

dwm_netspead(){
    #Get initial values
    get_bytes
    old_received_bytes=$received_bytes
    old_transmitted_bytes=$transmitted_bytes
    old_time=$now
    sleep 0.5
    # Get update values
    get_bytes
    # Calculates speeds
    vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
    vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)
    echo "$vel_recv $vel_trans"
}
