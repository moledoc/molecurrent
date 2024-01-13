# set x stuff
xrdb .Xresources
xsetroot -solid \#400040 -cursor_name top_left_arrow
setxkbmap -option "caps:swapescape" us
xset b off
# enable natural scrolling
touchpadID=$(xinput list | grep --color=none "Touchpad" | awk '{print $6}' | sed 's/id=//g')
propID=$(xinput list-props $touchpadID | grep "Natural Scrolling Enabled (" | sed 's/^[^*(]*(//;s/).*$//')
xinput set-prop $touchpadID $propID 1

# start programs
plumber &
sxhkd &
XSECURELOCK_PASSWORD_PROMPT=time_hex XSECURELOCK_FONT=DejaVuSans xautolock -time 10 -locker xsecurelock &
dunst &
playerctld &
low-battery.sh &
nohup flameshot &

# set states
feh --recursive --bg-fill --randomize /usr/share/backgrounds &
# printf "$(($MAX_BRIGHTNESS/2))\n" > /sys/class/backlight/intel_backlight/brightness # TODO:

exec /opt/9wm/9wm
