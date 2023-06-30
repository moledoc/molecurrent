#!/bin/sh
state=$(amixer set Capture toggle | grep -o "\[off\]\|\[on\]" | head -n 1 | sed 's/\[\|\]//g')
dunstify -a "toggleMic" -t 1000 -u low -h string:x-dunst-stack-tag:mic "Microphone: $state"
