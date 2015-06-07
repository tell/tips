#!/bin/bash

function show_clocks() {
	echo Available freqs.:
	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
	echo Available governors:
	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
	return 0
}

! { expr "$1" : '[0-9]*' > /dev/null; } && echo ERROR: Not a number. && show_clocks && exit 1

freq=$1
echo The frequencies of all CPUs are fixed as: $freq KHz.
echo Is it OK?
read INPUT

cpudir='/sys/devices/system/cpu/cpu*/cpufreq'

for x in $cpudir; do
  echo For $x:
  echo userspace > $x/scaling_governor
  echo $freq > $x/scaling_setspeed
done
