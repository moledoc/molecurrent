#!/bin/sh
# changeBrightness

test "$1" != "+" -a "$1" != "-" && printf "Incorrect argument, expected '+' or '-'\n" && exit 1
status=$(($(cat /sys/class/backlight/intel_backlight/brightness)$1$BRIGHTNESS_STEP))
printf "$status\n" > /sys/class/backlight/intel_backlight/brightness
statusNorm=$(($status*100/$MAX_BRIGHTNESS))
dunstify -a "changeBrighness" -t 500 -u low -h string:x-dunst-stack-tag:brightness -h int:value:"${statusNorm}" "Brightness: ${statusNorm}%"

