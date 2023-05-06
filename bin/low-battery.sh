#!/bin/sh

while true
do
	cap=$(cat /sys/class/power_supply/BAT0/capacity)
	test $cap -le 30 && \
		test "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" && \
		/usr/bin/dunstify -a "checkLowBattery" -t 10000 -u critical -h string:x-dunst-stack-tag:lowBattery -h int:value:"${cap}" "Battery low: ${cap}%"
	sleep 300
done
