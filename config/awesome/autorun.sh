# Monitors
xrandr --output DP-2 --output HDMI-0 --primary --mode 2560x1440 --right-of DP-2

# Compositor
picom &

# Lock screen
xscreensaver &

# Xresources
xrdb -merge ~/.Xresources

# Cursor
xsetroot -cursor_name arrow

# Mopidy
pgrep -x mopidy > /dev/null || mopidy &

# Gestures
pkill touchegg
rm ~/.config/touchegg/.*
touchegg &

# Applets
nm-applet &
blueman-applet &
 
# Emacs daemon
emacs --daemon

# Xinput
xinput set-button-map 13 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0
