# Monitors
xrandr --output HDMI-0 --primary --left-of DP-0 --auto # Primary monitor and positioning
xrandr --output DP-0 --rotate left # Rotate secondary monitor (It's vertical)

# Compositor
picom &

# Lock screen
xscreensaver &

# Music
mpd
mpd-mpris &
mpd-discord-rpc &

# Xinput
xinput set-button-map 17 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0

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
 
# Emacs daemon
emacs --daemon

# Discocss
discocss & sleep 2; pkill Discord

