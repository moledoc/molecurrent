#!/bin/sh
cap=$(cat /sys/class/power_supply/BAT0/capacity)
test $cap -le 100 && \
	test "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" && \
	dunstify -a "checkLowBattery" -t 10000 -u critical -h string:x-dunst-stack-tag:lowBattery -h int:value:"${cap}" "Battery low: ${cap}%"
