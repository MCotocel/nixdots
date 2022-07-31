# Compositor
picom &

# Music
mpd

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

