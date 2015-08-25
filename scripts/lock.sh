#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $HOME/Imágenes/icons/key-256.png ]] && convert /tmp/screen.png $HOME/Imágenes/icons/key-256.png -gravity center -composite -matte /tmp/screen.png
i3lock -u -i /tmp/screen.png
