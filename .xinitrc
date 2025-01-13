# background
feh --bg-scale $HOME/dwm/dwm.jpg &

## Status Bar
ztatusbar 2> zt.log &

# suspend
exec xautolock -time 30 -locker 'sudo systemctl poweroff' -detectsleep &
# exec xautolock -time 30 -locker 'sudo systemctl suspend' -detectsleep &

# window manager
exec dwm
