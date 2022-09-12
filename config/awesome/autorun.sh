# Xinput
xinput set-button-map $(xinput | grep "Logitech MX Master 3" | head -n 1 | sed -e 's/.*id=//g' -e 's/\[.*$//') 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0

# Monitors
xrandr --output DP-2 --output HDMI-0 --primary --mode 2560x1440 --right-of DP-2

# Xresources
xrdb -merge ~/.Xresources

# Cursor
xsetroot -cursor_name arrow

# Compositor
picom &

# Lock screen
xscreensaver &

# Monitor displays
watch -n 3 autorandr -c &

# Gestures
pkill touchegg
rm ~/.config/touchegg/.*
touchegg &

# Applets
nm-applet &
blueman-applet &
doas solaar -w hide &
 
# Emacs daemon
emacs --daemon

# MPD
if ! pidof mpd;
then
    mpd
fi
if ! pidof mpd-mpris;
then
    mpd-mpris
fi
if ! pidof mpd-discord-rpc;
then
    mpd-discord-rpc
fi
