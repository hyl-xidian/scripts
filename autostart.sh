#!/bin/bash

/bin/bash ~/scripts/dwm-status.sh &
#/bin/bash ~/scripts/wp-autochange.sh &
#/bin/bash ~/scripts/wp-change.sh &
/bin/bash ~/scripts/caps-swapescape.sh &
feh --recursive --bg-fill ~/Pictures/Wallpapers/test5.png
picom -o 0.8 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
#picom -b
#/bin/bash ~/scripts/setxmodmap-colemak.sh &
nm-applet &
xfce4-power-manager &
ss-qt5 &
/bin/bash ~/scripts/autostart_wait.sh &
