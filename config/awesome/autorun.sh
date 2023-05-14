# Autorandr
autorandr -c

# Xinput
watch -n 3 xinput set-button-map $(xinput | grep "Logitech MX Master 3" | head -n 1 | sed -e 's/.*id=//g' -e 's/\[.*$//') 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0 &

# Xresources
xrdb -merge ~/.Xresources

# Cursor
xsetroot -cursor_name arrow

# Lockscreen
xscreensaver --no-splash &

# Compositor
picom &

# Audio equaliser
easyeffects --gapplication-service &

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
if ! ps aux | grep cbatticon | grep -v grep;
then
    cbatticon &
fi
if ! ps aux | grep blueman-applet | grep -v grep;
then
    blueman-applet &
fi
if ! ps aux | grep pasystray | grep -v grep;
then
    pasystray &
fi
if ! ps aux | grep solaar | grep -v grep;
then
    solaar -w hide -b solaar &
fi
if ! ps aux | grep flameshot | grep -v grep;
then
    flameshot &
fi

# Monitor adjustment
#if ! ps aux | grep autorandr | grep -v grep;
#then
#    watch -n 1 autorandr -c &
#fi
 
# Emacs daemon
emacs --daemon

# MPD
#if ! pidof mpd;
#then
#    mpd
#fi
#if ! pidof mpd-mpris;
#then
#    mpd-mpris &
#fi
#if ! pidof mpd-discord-rpc;
#then
#    mpd-discord-rpc &
#fi

# Ambient lighting
#if ! ps aux | grep hyperiond | grep -v grep;
#then
#    hyperiond &
#fi
