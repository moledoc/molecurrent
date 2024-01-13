
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

## Author

Meelis Utt
