#!/bin/sh
# enable natural scrolling
touchpadID=$(xinput list | grep --color=none "Touchpad" | awk '{print $6}' | sed 's/id=//g')
propID=$(xinput list-props $touchpadID | grep "Natural Scrolling Enabled (" | sed 's/^[^*(]*(//;s/).*$//')
xinput set-prop $touchpadID $propID 1
