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
if command -v paru &> /dev/null || command -v yay &> /dev/null; then
  if command -v paru &> /dev/null; then
    kitty -T update paru -Syu
  else
    kitty -T update yay -Syu
  fi
  notify-send -i "$iDIR/ja.png" -u low 'Arch-based system' 'has been updated.'

elif command -v dnf &> /dev/null; then
  kitty -T update sudo dnf update --refresh -y
  notify-send -i "$iDIR/ja.png" -u low 'Fedora system' 'has been updated.'

elif command -v apt &> /dev/null; then
  kitty -T update sudo apt update && sudo apt upgrade -y
  notify-send -i "$iDIR/ja.png" -u low 'Debian/Ubuntu system' 'has been updated.'

elif command -v zypper &> /dev/null; then
  kitty -T update sudo zypper dup -y
  notify-send -i "$iDIR/ja.png" -u low 'openSUSE system' 'has been updated.'

else
  notify-send -i "$iDIR/error.png" -u critical "Unsupported system" "This script does not support your distribution(no supported pm)."
  exit 1
fi
