#!/bin/bash
#
#依据/proc/stat文件获取并计算CPU使用率
#
#CPU时间计算公式：CPU_TIME=user+system+nice+idle+iowait+irq+softirq
#CPU使用率计算公式：cpu_usage=(idle2-idle1)/(cpu2-cpu1)*100

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

dwm_cpu-usage_netspeed(){
    #Get initial values
    get_bytes
    old_received_bytes=$received_bytes
    old_transmitted_bytes=$transmitted_bytes
    old_time=$now
    LAST_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
    LAST_SYS_IDLE=$(echo $LAST_CPU_INFO | awk '{print $4}')
    LAST_TOTAL_CPU_T=$(echo $LAST_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')
    sleep 0.5
    NEXT_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
    NEXT_SYS_IDLE=$(echo $NEXT_CPU_INFO | awk '{print $4}')
    NEXT_TOTAL_CPU_T=$(echo $NEXT_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')
    #系统空闲时间
    SYSTEM_IDLE=`echo ${NEXT_SYS_IDLE} ${LAST_SYS_IDLE} | awk '{print $1-$2}'`
    #CPU总时间
    TOTAL_TIME=`echo ${NEXT_TOTAL_CPU_T} ${LAST_TOTAL_CPU_T} | awk '{print $1-$2}'`
    CPU_USAGE=`echo ${SYSTEM_IDLE} ${TOTAL_TIME} | awk '{printf "%.2f", 100-$1/$2*100}'`
    if [ $(echo "$CPU_USAGE >= 10.00" |bc) = 1 ]; then
        CPU_USAGE=`echo $CPU_USAGE | awk '{printf "%.1f", $1}'`
    fi
    # Get update values
    get_bytes
    # Calculates speeds
    vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
    vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)
    echo "$vel_recv $vel_trans $CPU_USAGE%"
}
