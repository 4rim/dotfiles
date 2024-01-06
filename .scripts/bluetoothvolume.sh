#!/bin/dash

# substr() function strips quotes from awk output
device_path=$(dbus-send --system --print-reply --dest=org.bluez / org.freedesktop.DBus.ObjectManager.GetManagedObjects | grep -B 8  "MediaTransport1" | awk '/object path/ { print substr($3,2,length($3)-2) }')
curr=$(dbus-send --system --print-reply --dest=org.bluez $device_path org.freedesktop.DBus.Properties.Get string:"org.bluez.MediaTransport1" string:"Volume" | awk '/uint16/ { print $3 }')

volumes="0\n10\n20\n30\n40\n50\n60\n70\n80\n90\n100\n110\n120"

num=$(echo $volumes | dmenu -p "Current vol: $curr")

dbus-send --system --print-reply --dest=org.bluez $device_path org.freedesktop.DBus.Properties.Set string:"org.bluez.MediaTransport1" string:"Volume" variant:uint16:"$num"
