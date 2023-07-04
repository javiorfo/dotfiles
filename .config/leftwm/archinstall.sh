#!/usr/bin/env bash
# Author: CaoSystema

sudo pacman -S --needed dmenu pamixer pulseaudio-alsa feh alacritty ttf-ubuntu-mono-nerd polybar
paru -S --needed leftwm lux

sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/

echo "Done!"
