#!/usr/bin/env bash

sudo pacman -S --needed dmenu pamixer feh alacritty ttf-iosevka-nerd polybar
paru -S --needed leftwm lux

sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/

echo "Done!"
