#!/bin/sh

action=$(printf "Terminal
Browser
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
Shutdown" | dmenu -l 18 -i)

case "$action" in
	"Terminal")
		x-terminal-emulator
		;;
	"Browser")
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
		xterm -e "su -c \"kill -9 $(pgrep -x dhclient);	
			/usr/sbin/dhclient -r;
			/usr/sbin/dhclient -4 -v -i -pf /run/dhclient.wlp2s0.pid -lf /var/lib/dhcp/dhclient.wlp2s0.leases -I -df /var/lib/dhcp/dhclient6.wlp2s0.leases wlp2s0;
		\""
		;;
	"Shortcuts")
		xterm -e "cat $HOME/.config/sxhkd/sxhkdrc | vi -"
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
		kill -9 $(pgrep -x 9wm)
		;;
	"Restart")
		confirm=$(printf "no\nyes" | dmenu -i -p "Are you sure you want to reboot")
		test "yes" = "$confirm" && /usr/sbin/reboot
		;;
	"Shutdown")
		confirm=$(printf "no\nyes" | dmenu -i -p "Are you sure you want to shutdown")
		test "yes" = "$confirm" && /usr/sbin/shutdown
		;;
esac