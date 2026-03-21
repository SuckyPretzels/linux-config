#!/bin/bash
#Change Workspace as if you pressed ctl-alt left-arrow 
#Resulting Workspace has its own Desktop Icons and Background
#
DeskLeft=$(wmctrl -d | grep -F '*' | cut -c1-1) 
if [[ $DeskLeft -gt 0 ]]
then ~/.local/bin/switch-desk.sh $DeskLeft 
fi
#end of script
