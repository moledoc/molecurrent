#!/bin/sh
msgTag="mywifi"
ssid=$(nmcli device wifi list | fzf -i --no-color | sed 's/\*/ /g' | awk '{print $2}')
test -z "$ssid" && exit 0
is_known=$(nmcli connection | grep "$ssid")
test -z is_known && nmcli device wifi connect "$ssid" password $(fzf -p "Password for '$ssid')
test -n is_known && nmcli device wifi connect "$ssid"
status=$(nmcli device wifi list | grep "*")
dunstify -a "changeWifi" -u low -h string:x-dunst-stack-tag:$msgTag "Connected to $ssid"

# if bluetoothctl gives: Bluetoothctl: No default controller available, despite being unblocked
# then the following helped me (as root)
# ```sh
# rmmod btusb
# rmmod btintel
# 
# modprobe btintel
# modprobe btusb
# ```
# source: https://unix.stackexchange.com/questions/169931/bluetoothctl-no-default-controller-available-despite-being-unblocked
