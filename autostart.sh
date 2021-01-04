#!/bin/bash

/bin/bash ~/scripts/caps-swapescape.sh &
/bin/bash ~/scripts/touchpad-disabled.sh &
feh --recursive --bg-fill ~/Pictures/Wallpapers/3.png
/bin/bash ~/scripts/wp-autochange.sh &
picom -b -C -G --config /home/lhy/.config/picom/picom.conf
xfce4-power-manager &
qv2ray &
/bin/bash ~/scripts/autostart_wait.sh &
