#!/bin/sh

# A dwm_bar module to display the current backlight brighness with xbacklight
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xbacklight acpilight 
#
dwm_backlight () {
    brightness=$(xbacklight -get)
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$brightness" -eq 0 ]; then
            echo "!!!"
        elif [ "$brightness" -gt 0 ] && [ "$brightness" -le 33 ]; then
            echo " $brightness%"
        elif [ "$brightness" -gt 33 ] && [ "$brightness" -le 66 ]; then
            echo "$brightness%"
        else
            echo "$brightness%"
        fi
    else
        echo "%.0f" "$brightness"
    fi 
}

dwm_backlight
