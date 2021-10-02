# Pre-flight checks
sh ~/.config/awesome/preflightchecks.sh

# Kmonad
pkill kmonad
kmonad ~/.config/kmonad/kmonad.kbd &

# Xresources
xrdb -merge ~/.Xresources

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
