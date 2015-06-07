#!/bin/bash

source functions.bash

cpudir='/sys/devices/system/cpu'
[ -d $cpudir ] || error_exit "ERROR: Not a directory: \"$cpudir\"."

echo Disable pseudo CPUs, e.g., HyperThreading, via sysfs.

siblings=''
for x in `ls -1 $cpudir/cpu*/topology/thread_siblings_list`; do
  sibling=`cat $x | tr "," "\n" | sort | uniq | tr "\n" ","`
  if [ -z "$siblings" ]; then
	siblings=$sibling
  else
	siblings=`echo -e "$siblings\n$sibling"`
  fi
done

ids=`echo "$siblings" | tr ',' ' ' | awk '{$1 = ""; print $0}' | sort | uniq`

echo Detected IDs: \"$ids\".
echo Are they OK?
read INPUT

for x in $ids; do
  targetfile=$cpudir'/cpu'$x'/online'
  [ -e $targetfile ] || error_exit "ERROR: Not exists: \"$targetfile\"."
  echo 0 > $targetfile
done
