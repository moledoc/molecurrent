#!/bin/sh
# pgrep -x dhclient | parallel "kill -9 {}"
rfkill block all && rfkill unblock all && su -c "/usr/sbin/dhclient -r; /usr/sbin/dhclient -4 -v -i -pf /run/dhclient.wlp2s0.pid -lf /var/lib/dhcp/dhclient.wlp2s0.leases -I -df /var/lib/dhcp/dhclient6.wlp2s0.leases wlp2s0"
