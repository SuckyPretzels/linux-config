#!/bin/bash

if wmctrl -x -R cinnamon-settings 2>/dev/null; then
    exit 0
else
    cinnamon-settings
fi
