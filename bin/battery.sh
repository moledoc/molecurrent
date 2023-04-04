#!/bin/sh
cap=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)
notify-send -u critical "Battery ${cap}% ${status}"
