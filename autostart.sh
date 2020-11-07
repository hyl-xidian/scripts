#!/bin/bash

/bin/bash ~/scripts/caps-swapescape.sh &
feh --recursive --bg-fill ~/Pictures/Wallpapers/overwatch_genji_2-wallpaper-1920x1080.png
picom -b -C -G --config /home/lhy/.config/picom/picom.conf
xfce4-power-manager &
v2ray -config /home/lhy/.config/v2ray/lhy.xidian.json &
#qv2ray &
/bin/bash ~/scripts/autostart_wait.sh &
