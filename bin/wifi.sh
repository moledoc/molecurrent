#!/bin/sh
msgTag="mywifi"
ssid=$(nmcli device wifi list | fzf -i --no-color | sed 's/\*/ /g' | awk '{print $2}')
test -z "$ssid" && exit 0
is_known=$(nmcli connection | grep "$ssid")
test -z is_known && nmcli device wifi connect "$ssid" password $(fzf -p "Password for '$ssid')
test -n is_known && nmcli device wifi connect "$ssid"
status=$(nmcli device wifi list | grep "*")
dunstify -a "changeWifi" -u low -h string:x-dunst-stack-tag:$msgTag "Connected to $ssid"
