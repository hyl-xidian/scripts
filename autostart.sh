#!/bin/bash

xmodmap ~/.Xmodmap &
xfce4-power-manager &
qv2ray &
#/bin/bash ~/scripts/caps-swapescape.sh &
/bin/bash ~/scripts/touchpad-disabled.sh &
/bin/bash ~/scripts/wp-autochange.sh &
picom -b -C -G --config /home/lhy/.config/picom/picom.conf
#nm-applet &
/bin/bash ~/scripts/autostart_wait.sh &
