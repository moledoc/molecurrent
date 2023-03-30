#!/bin/sh

msgTag="mydatetime"
dunstify -a "datetime" -u low -h string:x-dunst-stack-tag:$msgTag -h int:value:"datetime" "$(date)"
