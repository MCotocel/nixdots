# Monitors
xrandr --output HDMI-0 --primary

# Compositor
picom &

# Lock screen
xscreensaver &

# Xinput
xinput set-button-map 13 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0

# Xresources
xrdb -merge ~/.Xresources

# Cursor
xsetroot -cursor_name arrow

# Mopidy
pgrep -x mopidy > /dev/null || mopidy &

# Gestures
touchegg &

# Applets
nm-applet &
blueman-applet &

# Discocss
discocss & sleep 2; pkill Discord
 
# Emacs daemon
emacs --daemon
