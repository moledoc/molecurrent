#!/bin/sh
cur=$(setxkbmap -query | grep --color=none "layout" | sed 's/layout:     //g')
case $cur in
	"us") new=ee ;;
	"ee") new=us ;;
esac
setxkbmap -layout $new
notify-send -u low "Language: $new"
