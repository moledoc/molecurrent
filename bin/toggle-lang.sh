#!/bin/sh
cur=$(setxkbmap -query | grep --color=none "layout" | sed 's/layout:     //g')
case $cur in
	"us") new=ee ;;
	"ee") new=us ;;
esac
setxkbmap -option "caps:swapescape" -layout $new
dunstify -a "changeLayout" -t 500 -u low -h string:x-dunst-stack-tag:lang "Language: $new"
