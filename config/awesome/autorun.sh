# Autorandr
autorandr -c

# Xinput
watch -n 3 xinput set-button-map $(xinput | grep "Logitech Wireless Device PID:4082" | head -n 1 | sed -e 's/.*id=//g' -e 's/\[.*$//') 1 2 3 4 5 6 7 12 13 0 0 0 0 0 0 &

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

# Kmonad
if ! ps aux | grep kmonad | grep -v grep;
then
    kmonad ~/.config/kmonad/coolermaster.kbd &
fi

# Emacs
emacs --daemon
