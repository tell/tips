#!/bin/sh

cpudir='/sys/devices/system/cpu'
[ ! -d $cpudir ] && echo ERROR: Not a directory: $cpudir. && exit 1

echo Disable pseudo CPUs \(e.g., HyperThreading\) by the soft-way.

siblings=''
for x in `ls -1 $cpudir/cpu*/topology/thread_siblings_list`; do
  sibling=`cat $x | tr "," "\n" | sort | uniq | tr "\n" ","`
  siblings=$siblings-"$sibling"
done

ids=`echo $siblings | tr '-' '\n' | tr ',' ' ' | awk '{print $2}' | sort | uniq`

echo Detected IDs:
for x in $ids; do
  echo $x
done
echo Are they OK?
read INPUT

set -x
for x in $ids; do
  targetfile=$cpudir'/cpu'$x'/online'
  [ ! -e $targetfile ] && echo ERROR: Not exists: $targetfile.
  echo 0 > $targetfile
done
