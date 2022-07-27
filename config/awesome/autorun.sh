# Pre-flight checks
sh ~/.config/awesome/preflightchecks.sh

# Kmonad
pkill kmonad
kmonad ~/.config/kmonad/kmonad.kbd &

# Xinput
xinput set-button-map 17 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0

# Xresources
xrdb -merge ~/.Xresources

# Discocss
discocss & sleep 2; pkill Discord

# Compositor
picom &

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
