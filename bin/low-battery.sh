#!/bin/sh
test $(cat /sys/class/power_supply/BAT0/capacity) -le 30 && \
	test "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" && \
	dunstify -a "battery" -u critical -h string:x-dunst-stack-tag:mybattery "Battery low"
