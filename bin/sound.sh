#!/bin/sh
# changeVolume

# Change the volume using alsa
amixer -q set Master "$@"
status=$(amixer get Master | tail -1)
# status=$(amixer -c 0 get Master | tail -1)

# Query amixer for the current volume and whether or not the speaker is muted
volume="$(echo $status | grep -oE --color=none '[0-9]{1,3}%')"
mute="$(echo $status |  grep -oE --color=none '\[[onf]{1,3}' | tr -d '[')"
test $volume = 0 -o "$mute" = "off" && \
	# Show the sound muted notification
	dunstify -a "changeVolume" -t 500 -u low -h string:x-dunst-stack-tag:vol -h int:value:0 "Volume muted" || \
	# Show the volume notification
	dunstify -a "changeVolume" -t 500 -u low -h string:x-dunst-stack-tag:vol -h int:value:"${volume}" "Volume: ${volume}"
