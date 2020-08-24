#!/bin/sh

# A dwm_bar module to display the current backlight brighness with xbacklight
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xbacklight

dwm_backlight () {
    brightness=$(xbacklight -get)
    printf "%s" "$SEP1"
    printf "☀ %.0f%s" "$brightness" "%"
    printf "%s" "$SEP2"
}

dwm_backlight
