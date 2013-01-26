#!/bin/sh
#cat /proc/acpi/thermal_zone/THM0/temperature | while read CPU_TEMP; do notify-send -t 3500 "CPU Temperature" \ "$CPU_TEMP"; done
acpi -t | while read CPU_TEMP; do notify-send -t 3500 "CPU Temperature" \ "$CPU_TEMP"; done
