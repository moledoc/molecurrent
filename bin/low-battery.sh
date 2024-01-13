#!/bin/sh

limit=30
test -n "$1" && limit="$1"

while true
do
	cap=$(cat /sys/class/power_supply/BAT0/capacity)
	test $cap -le $limit && \
		test "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" && \
		/usr/bin/dunstify -a "checkLowBattery" -t 10000 -u critical -h string:x-dunst-stack-tag:lowBattery -h int:value:"${cap}" "Battery low: ${cap}%"
	sleep 300
done
