#!/bin/bash

# I used this script in Lenovo Carbon X1 
# to disable the mouse track.

output=$(xinput list | grep TouchPad)
# removing everything up to (including) the '='
a=${output#*=}
# removing everything after (including) the first whitespace (tab, return, space)
b=${a%%[[:blank:]]*}
xinput -set-prop $b "Device Enabled" 0
