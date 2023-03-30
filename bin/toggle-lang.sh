#!/bin/sh
cur=$(setxkbmap -query | grep --color=none "layout" | sed 's/layout:     //g')
case $cur in
	"us") new=ee ;;
	"ee") new=us ;;
esac
setxkbmap -layout $new
dunstify -a "changeLang" -u low -h string:x-dunst-stack-tag:myLang -h int:value:"$new" "Language: $new"
# update_dwmbar.sh
