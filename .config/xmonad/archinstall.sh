#!/usr/bin/env bash
# Author: CaoSystema

sudo pacman -S --needed xmonad xmonad-contrib xmobar pamixer xautolock pulseaudio-alsa feh alacritty ttf-ubuntu-mono-nerd

sudo cp 00-keyboard.conf /etc/X11/xorg.conf.d/

echo "Done!"
