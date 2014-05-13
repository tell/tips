#!/bin/sh

! { expr "$1" : '[0-9]*' > /dev/null; } && echo ERROR: Not a number. && exit 1

freq=$1
echo Input frequency is: $freq KHz.
echo Is it OK?
read INPUT

cpudir='/sys/devices/system/cpu/cpu*/cpufreq'

set -x
for x in $cpudir; do
  echo For $x:
  echo userspace > $x/scaling_governor
  echo $freq > $x/scaling_setspeed
done
