#!/bin/sh

# A dwm_bar module to display the current backlight brighness with xbacklight
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xbacklight acpilight 
#
dwm_backlight () {
    brightness=$(xbacklight -get)
    if [ "$IDENTIFIER" = "unicode" ]; then
        #printf "☀ %.0f%s" "$brightness" "%"
        echo "☀$brightness%"
    else
        printf "%.0f" "$brightness"
    fi 
}

dwm_backlight
