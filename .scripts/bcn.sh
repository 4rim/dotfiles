#!/bin/dash

num_devices=$(bluetoothctl devices | wc -l)
tag="string:x-dunst-stack-tag:bt"

if [ $num_devices -eq 0 ]; then
    echo "Devices not found." && exit 0
elif [ $num_devices -eq 1 ]; then
    MAC=$(bluetoothctl devices | awk '{ print $2 }')
else
    select=$(bluetoothctl devices | awk '{ print $3 }' | dmenu -l $num_devices)
    MAC=$(bluetoothctl devices | awk '/'"$select"'/ { print $2 }')
fi

is_connected=$(bluetoothctl info $MAC | awk '/Connected:/ { print $2 }')

if [ $is_connected = "no" ]; then
    dunstify -h $tag -u normal "Attempting to connect to $select".
    bluetoothctl connect $MAC; bat=$(bluetoothctl info $MAC | awk '/Battery Percentage:/ { print substr($4,2,length($4)-2) }')
    dunstify -h $tag -u normal "Connected to $select!" || dunstify -h $tag -u critical "Failed to connect to $select".
else
    dunstify -h $tag -u normal "Attempting to disconnect from $select"
    (bluetoothctl disconnect $MAC && dunstify -h $tag -u normal "Disconnected from $select successfully. (Battery: $bat)") || dunstify -h $tag -u critical "Failed to disconnect from $select."
fi
