# If running VM
vmware-user

# Keyboard repeat rate
xset r rate 200 25

# Resolution
#xrandr --newmode "2560x1440"  241.500   2560 2608 2640 2720  1440 1443 1448 1481 +hsync -vsync
#xrandr --addmode Virtual1 "2560x1440"
#xrandr --output Virtual1 --mode 2560x1440
#xrandr --newmode "5120x2880_60.00" 1276.50 5120 5560 6128 7136 2880 2883 2888 2982 -hsync +vsync
#xrandr --addmode Virtual1 "5120x2880_60.00"
#xrandr --output Virtual1 --mode 5120x2880_60.00

# Mouse cursor
xsetroot -cursor_name arrow

# Wallpaper
#nitrogen --restore
 
# Compositor
picom --experimental-backends

# Auth
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# QT scale
export QT_SCALE_FACTOR=2

# QT theme
export QT_QPA_PLATFORMTHEME=qt5ct

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
