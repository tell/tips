#!/bin/bash

source functions.bash

cpudir='/sys/devices/system/cpu'
[ -d $cpudir ] || error_exit "ERROR: Not a directory: \"$cpudir\"."

echo Enable all CPUs via sysfs.
echo OK?
read INPUT

for x in `ls -1 $cpudir/cpu*/online`; do
	echo 1 > $x
	[ $? -eq 0 ] && echo Overwrode \"$x\" by 1.
done
