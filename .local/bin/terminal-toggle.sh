#!/bin/bash

if wmctrl -x -R kitty.Kitty 2>/dev/null; then
    exit 0
else
    kitty &
fi

