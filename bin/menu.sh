#!/bin/sh

action=$(printf "Terminal
Browswer
Files
Mail
Acme
Screenshot
Keepass
Datetime
Battery
Wifi
Reset Wifi
Shortcuts
Wallpaper
Restart sxhkd
Lock
Logout
Restart
Shutdown" | dmenu -l 18)

case "$action" in
	"Terminal")
		x-terminal-emulator
		;;
	"Browswer")
		x-www-browser
		;;
	"Files")
		spacefm
		;;
	"Mail")
		thunderbird
		;;
	"Acme")
		start-acme.sh
		;;
	"Screenshot")
		flameshot launcher
		;;
	"Keepass")
		keepassxc
		;;
	"Datetime")
		datetime.sh
		;;
	"Battery")
		battery.sh
		;;
	"Wifi")
		xterm -e nmtui
		;;
	"Reset Wifi")
		pgrep -x dhclient | xargs -I {} kill -9 "{}"	
		doas /usr/sbin/dhclient -r
		doas /usr/sbin/dhclient -4 -v -i -pf /run/dhclient.wlp2s0.pid -lf /var/lib/dhcp/dhclient.wlp2s0.leases -I -df /var/lib/dhcp/dhclient6.wlp2s0.leases wlp2s0
		;;
	"Shortcuts")
		xterm -e "man evilwm | cat $HOME/.config/sxhkd/sxhkdrc - | vi -"
		;;
	"Shortcuts")
		xterm -e "man evilwm | cat $HOME/.config/sxhkd/sxhkdrc - | vi -"
		;;
	"Wallpaper")
		xdotool key ctrl+alt+w+p
		;;
	"Restart sxhkd")
		xdotool key super+k+r
		;;
	"Lock")
		xdotool key super+l
		;;
	"Logout")
		pgrep -x evilwm | xargs -I {} kill -9 "{}"
		;;
	"Restart")
		confirm=$(printf "no\nyes" | dmenu -p "Are you sure you want to reboot")
		test "yes" == "$confirm" && /usr/sbin/reboot
		;;
	"Shutdown")
		confirm=$(printf "no\nyes" | dmenu -p "Are you sure you want to shutdown")
		test "yes" == "$confirm" && /usr/sbin/shutdown
		;;
esac
