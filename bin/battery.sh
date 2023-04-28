#!/bin/sh
cap=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
dunstify -a "checkBattery" -t 2000 -u low -h string:x-dunst-stack-tag:battery -h int:value:"${cap}" "${status}: ${cap}%"
