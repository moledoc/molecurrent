#!/bin/sh
dunstify -a "checkDateTime" -t 3000 -u low -h string:x-dunst-stack-tag:datetime "$(date -R)"
