#!/bin/bash
#Changes Workspace as if you pressed ctl-alt right-arrow 
#Resulting Workspace has its own Desktop Icons and Background
#
DeskMax=$(wmctrl -d | wc -l)
DeskCurrent=$(($(wmctrl -d | grep -F '*' | cut -c1-1)+1))
if [[ $DeskMax -gt $DeskCurrent ]]
then ~/.local/bin/switch-desk.sh $(($DeskCurrent+1))
fi
#end of script
