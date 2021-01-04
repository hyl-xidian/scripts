#!/bin/bash

# Get id of touchpad and the id of the field corresponding to
# tapping to click
id=`xinput list | grep "TouchPad" | cut -d'=' -f2 | cut -d'[' -f1`
Device_enabled_id=`xinput list-props $id | \
                      grep "Device Enabled (" \
                      | cut -d'(' -f2 | cut -d')' -f1`

# Set the property to true
xinput --set-prop $id $Device_enabled_id 1
