# background
feh --bg-scale $HOME/dwm/dwm.jpg &

## Status Bar
xtatusbar &

# suspend
exec xautolock -time 30 -locker 'sudo systemctl poweroff' -detectsleep &
# exec xautolock -time 30 -locker 'sudo systemctl suspend' -detectsleep &

# window manager
exec dwm
