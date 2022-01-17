SECOND_SCREEN=$(xrandr | grep " connected" | grep -v eDP | awk '{print $1}')
echo detected 2nd screen $SECOND_SCREEN
# setup the output screens
xrandr --output $SECOND_SCREEN --auto
xrandr --output $SECOND_SCREEN --right-of eDP-1-1

# set resolution
xrandr --output $SECOND_SCREEN  --mode 2560x1440

# set wallpaper
feh --bg-fill ~/Downloads/pexels-stein-egil-liland-1933239.jpg
