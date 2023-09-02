# set x stuff
xrdb .Xresources
xetroot -solid \#400040 -cursor_name top_left_arrow
setxkbmap -option "caps:swapescape" us
xset b off

# start programs
plumber &
sxhkd &
xautolock -time 10 -locker slock &
dunst &
playerctld &
low-battery.sh &

# set states
feh --recursive --bg-fill --randomize /usr/share/backgrounds &
printf "$(($MAX_BRIGHTNESS/2))\n" > /sys/class/backlight/intel_backlight/brightness
natural-scrolling.sh &

exec /home/utt/molecurrent/9wm/9wm
