
# molecurrent

This particular setup is meant to be more mouse-based/-centric and has a lot of influences from plan9.

I do enjoy the simplicity of this build.
I've hacked around in some programs to add minor features that I was missing or to enable some features already present, but not accessible.

## setup 

Login as root

```{.sh}
wget https://raw.githubusercontent.com/moledoc/molecurrent/main/setup.sh
chmod +x setup.sh
./setup.sh
```

## Programs

* window manager - 9wm
* web browser - chromium
* text editor - acme/vi
* terminal - xterm or any other default one
* file manager - spacefm/acme
* keyboard shortcuts - sxhkd
	* volume
	* brightness
	* term
	* keyboard language switch
	* (could use for other things, but want to force 9menu usage)
* notifications - dunst
* lockscreen - xsecurelock
* autolocker - xautolock
* wifi - nmtui (also useful wpa_gui, wpa_supplicant and nmcli)
* screenshots - flameshot
* media player - vlc
* pdf viewer - okular
* image viewer - feh (also sets the background)
* bluetooth - bluetoothctl

## Helpful material

### Bluetooth

This article was very helpful: `https://www.makeuseof.com/manage-bluetooth-linux-with-bluetoothctl/`

```sh
doas systemctl status bluetooth
doas systemctl enable bluetooth
bluetoothctl scan on # to find the wanted bluetooth device
bluetoothctl discoverable on
bluetoothctl pair <device address> # for new device
bluetoothctl paired-devices # list paired devices
bluetoothctl connect <device address> # for existing device
bluetoothctl (un)trust <device address>
bluetoothctl disconnect <device address>
bluetoothctl remove <device address>
bluetoothctl block <device address>
```

### Wifi issues

Every reboot/coming out of sleep - no wifi

Haven't figured out the root cause, but running `dhclient` seems to help.

```sh
rfkill block all && rfkill unblock all
doas /usr/sbin/dhclient -r # release current lease
doas /usr/sbin/dhclient -4 -v -i -pf /run/dhclient.wlp2s0.pid -lf /var/lib/dhcp/dhclient.wlp2s0.leases -I -df /var/lib/dhcp/dhclient6.wlp2s0.leases wlp2s0
```

Another thing that might help is ([source](https://www.linuxquestions.org/questions/linux-networking-3/returning-wifi-and-dhclient-after-suspend-4175552061/))

```sh
wpa_passphrase ${ssid} ${password} | doas tee /etc/wpa_supplicant/${ssid}.conf
```

#### Older help

copied from moledebian\_min

I had some issues with wifi. Made 2 sections: one for quick commands and second to expand on those commands and actions.

##### TLDR;

* [get iso w/ non-free drivers](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.4.0+nonfree/amd64/iso-cd/)
* [get tarbal](https://cdimage.debian.org/cdimage/unofficial/non-free/firmware/bookworm/20220801/firmware.tar.gz) and extract it to `/firmware/` on a separate USB
	* when installing connect the USB and select 'load firmware -> yes'
* Run commands:
```sh
% PATH=$PATH:/sbin
% wpa_passphrase <WifiName> > /etc/wpa_supplicant.conf
% wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp2s0
% dhclient wlp2s0
% apt install network-manager
% nmcli --ask dev wifi connect <WifiName>
```

##### With some comments

* [helpful article](https://linuxhint.com/remove_characters_string_bash/)

At first it seemed that programs related to setting up wifi are not included in the just 'system utilities' version of debian install.
Furthermore, my laptop needed some non-free drivers.
So I resolved this by:
* install the firmware iso version (normal iso might also work, I got mine setup working with the firmware-netinst.iso)
	* firmware-netinst.iso for debian 11.4 https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.4.0+nonfree/amd64/iso-cd/
* install firmware tarbal (https://cdimage.debian.org/cdimage/unofficial/non-free/firmware/bookworm/20220801/firmware.tar.gz) and extract it to root folder named 'firmware' on a separate USB-stick.
	* this solved my missing driver issues after which the installation contained programs to get the wifi running
* the necessary binaries are in `/sbin`, which for me was **not** in `PATH`. To type less, I assume `/sbin` is added to the `PATH`
```sh
% PATH=$PATH:/sbin
```
* The way I got my wifi running:
	* switch to root (didn't have sudo nor doas at that point)
```sh
% wpa_passphrase <WifiName> | tee /etc/wpa_supplicant.conf
% wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp2s0
```
	* switch to new tty
	* switched to root
```sh
% dhclient wlp2s0
```
	* installed `network-manager`
```sh
% apt install network-manager
```
	* switched back to first tty and killed the `wpa_supplicant` command
	* bring up wifi with `nmcli`
```sh
% nmcli --ask dev wifi connect <WifiName>
```
