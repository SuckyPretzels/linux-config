#!/bin/bash

# Sync home into .dotfiles (add more rsync lines below for other directories like .local/share, .zshrc, etc.)
rsync -av --delete \
   --filter='merge /home/pretzels/.dotfiles-filter.txt' \
   ~/ ~/.dotfiles

echo "Dotfiles updated at $(date)"

