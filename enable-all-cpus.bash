#!/bin/sh

cpudir='/sys/devices/system/cpu'
[ ! -d $cpudir ] && echo ERROR: Not a directory: $cpudir. && exit 1

echo Enable all CPUs by the soft-way.
echo OK?
read INPUT

set -x
for x in `ls -1 $cpudir/cpu*/online`; do
	if [ ! -e $x ]; then
		echo ERROR: Not exists: $x.
	else
		echo 1 > $x
	fi
done
