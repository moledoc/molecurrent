# set x stuff
xrdb .Xresources
xsetroot -solid \#400040 -cursor_name top_left_arrow
setxkbmap -option "caps:swapescape" us
xset b off

# start programs
plumber &
sxhkd &
XSECURELOCK_PASSWORD_PROMPT=time_hex XSECURELOCK_FONT=DejaVuSans xautolock -time 10 -locker xsecurelock &
dunst &
playerctld &
low-battery.sh &

# set states
feh --recursive --bg-fill --randomize /usr/share/backgrounds &
# printf "$(($MAX_BRIGHTNESS/2))\n" > /sys/class/backlight/intel_backlight/brightness # TODO:
natural-scrolling.sh &

exec /opt/9wm/9wm
