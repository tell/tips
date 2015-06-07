#!/bin/bash

echo The frequencies of all CPUs to be variable.
echo Is it OK?
read INPUT

cpudir='/sys/devices/system/cpu/cpu*/cpufreq'

for x in $cpudir; do
  echo For $x:
  echo ondemand > $x/scaling_governor
done
