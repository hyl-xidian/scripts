#!/bin/bash

/bin/bash ~/scripts/dwm-status.sh &
#/bin/bash ~/scripts/wp-autochange.sh &
/bin/bash ~/scripts/wp-change.sh &
picom -o 0.75 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
picom -b
/bin/bash ~/scripts/tap-to-click.sh &
/bin/bash ~/scripts/inverse-scroll.sh &
#/bin/bash ~/scripts/setxmodmap-colemak.sh &
nm-applet &
xfce4-power-manager &
ss-qt5 &
#xfce4-volumed-pulse &
#/bin/bash ~/scripts/run-mailsync.sh &
#/bin/bash ~/scripts/autostart_wait.sh &
