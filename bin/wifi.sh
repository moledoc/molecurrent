#!/bin/sh
msgTag="mywifi"
ssid=$(nmcli device wifi list | fzf -i --no-color | sed 's/\*/ /g' | awk '{print $2}')
test -z "$ssid" && exit 0
is_known=$(nmcli connection | grep "$ssid")
# TODO: read password doesn't work
test -z is_known && password=$(read -p "Password for '$ssid': " <&-)
test -n is_known && nmcli device wifi connect "$ssid" || nmcli device wifi connect "$ssid" password "$password"
status=$(nmcli device wifi list | grep "*")
dunstify -a "changeWifi" -u low -h string:x-dunst-stack-tag:$msgTag "Connected to $ssid"
