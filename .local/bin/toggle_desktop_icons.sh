#!/bin/bash

# Toggle desktop icons visibility in Cinnamon (Nemo desktop)
CURRENT=$(gsettings get org.nemo.desktop show-desktop-icons)

if [ "$CURRENT" = "true" ]; then
    gsettings set org.nemo.desktop show-desktop-icons false
    notify-send "Desktop Icons" "Desktop icons are now **hidden**" -i desktop
else
    gsettings set org.nemo.desktop show-desktop-icons true
    notify-send "Desktop Icons" "Desktop icons are now **visible**" -i desktop
fi
