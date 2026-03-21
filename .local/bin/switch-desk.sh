#!/bin/bash
#Switch Workspace to $1 Workspace with its own Background and Desktop icons
cd ~/Desks  #The Desks folder keeps the backgrounds for each Desk
Desk=$(xdg-user-dir DESKTOP)  #Fetch location of Desktop.
DeskN=$(($(awk '{print $NF}' <<< $(xprop -root -notype  _NET_CURRENT_DESKTOP))+1))
echo "$(gsettings get org.cinnamon.desktop.background picture-uri)" > "BG$DeskN"
ln -sfn Desk$1 $Desk    #Make Desk$1 the new Desktop
wmctrl -s $(($1-1))  #Use wmctrl to switch Workspace (N.B., 1st workspace is 0)
gsettings set org.nemo.desktop desktop-layout 'false::false'
gsettings set org.nemo.desktop desktop-layout 'true::false'
read -er BG < "BG$1"  #BG will contain the contents of BG$1
gsettings set org.cinnamon.desktop.background picture-uri "$BG"  #Change the background 

#end of script
