# Xinput
watch -n 3 xinput set-button-map $(xinput | grep "Logitech MX Master 3" | head -n 1 | sed -e 's/.*id=//g' -e 's/\[.*$//') 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0 &

# Monitors
xrandr --output DP-2 --mode 1920x1080 --pos 0x360 --rotate normal 
xrandr --output DP-0.1 --mode 2560x1440 --pos 1920x0 --rotate normal
#xrandr --output HDMI-0 --mode 1920x1080 --pos 4480x0 --rotate left
#
# Xresources
xrdb -merge ~/.Xresources

# Cursor
xsetroot -cursor_name arrow

# Compositor
picom &

## Monitor displays
#if ! ps aux | grep autorandr | grep -v grep;
#then
#    watch -n 1 autorandr -c &
#fi

# Gestures
rm ~/.config/touchegg/.*
if ! ps aux | grep nm-applet | grep -v grep;
then
    touchegg &
fi

# Applets
if ! ps aux | grep nm-applet | grep -v grep;
then
    nm-applet &
fi
if ! ps aux | grep blueman-applet | grep -v grep;
then
    blueman-applet &
fi
if ! ps aux | grep solaar | grep -v grep;
then
    doas solaar -w hide &
fi
 
# Emacs daemon
emacs --daemon

# MPD
if ! pidof mpd;
then
    mpd
fi
if ! pidof mpd-mpris;
then
    mpd-mpris &
fi
if ! pidof mpd-discord-rpc;
then
    mpd-discord-rpc &
fi
