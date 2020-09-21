#!/bin/bash

/bin/bash ~/scripts/dwm-status.sh &
#/bin/bash ~/scripts/wp-autochange.sh &
#/bin/bash ~/scripts/wp-change.sh &
/bin/bash ~/scripts/caps-swapescape.sh &
feh --recursive --bg-fill ~/Pictures/Wallpapers/orig.png
picom -b --config /home/lhy/.config/picom/picom.conf
#/bin/bash ~/scripts/setxmodmap-colemak.sh &
nm-applet &
xfce4-power-manager &
qv2ray &
/bin/bash ~/scripts/autostart_wait.sh &
