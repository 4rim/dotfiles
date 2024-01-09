#!/bin/dash

num_devices=$(bluetoothctl devices | wc -l)
tag="string:x-dunst-stack-tag:bt"

if [ $num_devices -eq 0 ]; then
    echo "Devices not found." && exit 0
elif [ $num_devices -eq 1 ]; then
    MAC=$(bluetoothctl devices | awk '{ print $2 }')
else
    select=$(bluetoothctl devices | awk '{ print $3 }' | sed -e "$num_devices a Cancel" | dmenu -l $(($num_devices+1)))
    [ $select = "Cancel" ] && exit 0
    MAC=$(bluetoothctl devices | awk '/'"$select"'/ { print $2 }')
fi

is_connected=$(bluetoothctl info $MAC | awk '/Connected:/ { print $2 }')

if [ $is_connected = "no" ]; then
    dunstify -h $tag -u normal "Attempting to connect to $select".
    bluetoothctl connect $MAC
    dunstify -h $tag -u normal "Connected to $select!" || dunstify -h $tag -u critical "Failed to connect to $select".
else
    dunstify -h $tag -u normal "Attempting to disconnect from $select"
    (bluetoothctl disconnect $MAC && dunstify -h $tag -u normal "Disconnected from $select successfully.") || dunstify -h $tag -u critical "Failed to disconnect from $select."
fi
