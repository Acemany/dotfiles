#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Monitor backlights (if supported) using brightnessctl

iDIR="$HOME/.config/swaync/icons"
notification_timeout=1000
step=128  # INCREASE/DECREASE BY THIS VALUE

monitor_data=$(hyprctl monitors -j)
focused_id=$(( $(echo $monitor_data | jq -r '.[] | select(.focused == true) | .id') + 1 ))
vcp_value=$(ddcutil --display=$focused_id getvcp 10 | cut -d: -f2)

# Get brightness
get_backlight() {
	echo "scale=2; $(echo $vcp_value | cut -d, -f1 | cut -d= -f2)/$(echo $vcp_value | cut -d= -f3)*100" | bc | cut -d. -f1
}

# Get icons
get_icon() {
	current=$(get_backlight)
	if   [ "$current" -le "20" ]; then
		icon="$iDIR/brightness-20.png"
	elif [ "$current" -le "40" ]; then
		icon="$iDIR/brightness-40.png"
	elif [ "$current" -le "60" ]; then
		icon="$iDIR/brightness-60.png"
	elif [ "$current" -le "80" ]; then
		icon="$iDIR/brightness-80.png"
	else
		icon="$iDIR/brightness-100.png"
	fi
}

# Notify
notify_user() {
	notify-send -e -h string:x-canonical-private-synchronous:brightness_notif -h int:value:$current -u low -i $icon "Screen" "Brightness:$current%"
}

# Change brightness
change_backlight() {
	#focused_name=$(echo $monitor_data | jq -r '.[] | select(.focused == true) | .name')

	#if [ "$focused_name" == "eDP-1" ]; then
		# Internal display
		#if [ "$direction" == "-" ]; then
		#    brillo -u 150000 -U $step
		#else
		#    brillo -u 150000 -A $step
		#fi
	#else
	# External display
		ddcutil --display=$focused_id setvcp 10 ${1:?} $step
	#fi

	get_icon
	current=$(get_backlight)
	notify_user
}

# Execute accordingly
case "$1" in
	"--get")
		get_backlight
		;;
	"--inc")
		change_backlight "+"
		echo "{\"text\":\"$(get_backlight)\"}"
		;;
	"--dec")
		change_backlight "-"
		echo "{\"text\":\"$(get_backlight)\"}"
		;;
	"--json")
		echo "{\"text\":\"$(get_backlight)\"}"
		;;
	*)
		get_backlight
		;;
esac
