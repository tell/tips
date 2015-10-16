#!/bin/bash

cpus=$(find /sys/devices/system/cpu -mindepth 1 -maxdepth 1 -type d -regex '.*/cpu[0-9]+')

echo Show frequencies of cpus:
for x in $cpus; do
	cur_freq="$x/cpufreq/cpuinfo_cur_freq"
	sc_gov="$x/cpufreq/scaling_governor"
	th_sib="$x/topology/thread_siblings_list"
	echo at $(basename $x):
	echo "  Freq.: $(cat $cur_freq)"
	echo "  Gov.: $(cat $sc_gov)"
	echo "  Sibs.: $(cat $th_sib)"
done
