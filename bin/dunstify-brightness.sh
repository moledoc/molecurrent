#!/bin/sh
# changeBrightness

test "$1" != "+" -a "$1" != "-" && printf "Incorrect argument, expected '+' or '-'\n" && exit 1
# Arbitrary but unique message tag
msgTag="mybrightness"
status=$(($(cat /sys/class/backlight/intel_backlight/brightness)$1$BRIGHTNESS_STEP))
echo $status | doas tee /sys/class/backlight/intel_backlight/brightness
dunstify -a "changeBrightness" -u low -h string:x-dunst-stack-tag:$msgTag -h int:value:"$status" "Brightness: $(($status*100/$MAX_BRIGHTNESS))%"
