#!/bin/sh
test $(cat /sys/class/power_supply/BAT0/capacity) -le 30 && \
	test "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" && \
	notify-send -u critical "Battery low"
