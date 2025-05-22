#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Simple bash script to check and will try to update your system

# Local Paths
iDIR="$HOME/.config/swaync/images"

# Check for required tools (kitty)
if ! command -v kitty &> /dev/null; then
  notify-send -i "$iDIR/error.png" "Need Kitty:" "Kitty terminal not found. Please install Kitty terminal."
  exit 1
fi

# Detect distribution and update accordingly
if command -v nyay &> /dev/null; then
  kitty -T update nyay -Syu
  notify-send -i "$iDIR/ja.png" -u low 'Arch-based system' 'has been updated.'
else
  notify-send -i "$iDIR/error.png" -u critical "Unsupported system" "This script does not support your distribution(no supported pm)."
  exit 1
fi
