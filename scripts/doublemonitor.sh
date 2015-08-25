#!/bin/bash

hay_monitor=$(xrandr | grep "VGA-0 disconnected")

if [ -n "$hay_monitor" ]; then
    echo "No existe el monitor VGA"
else
    xrandr --output VGA-0 --mode 1440x900 --left-of LVDS 
    xrandr --output LVDS --mode 1366x768          
    xrandr --output LVDS --primary
    nitrogen --restore
    echo "Monitor VGA configurado a la izquierda"
fi
