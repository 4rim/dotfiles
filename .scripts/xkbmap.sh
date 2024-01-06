#!/bin/dash

layout=$(setxkbmap -query | awk '/layout/ {print $2}')

if [ "$layout" = "us" ]; then
	setxkbmap ru
        dunstify -u normal -h string:x-dunst-stack-tag:xkb 'Keyboard: RU'
else
	setxkbmap us
        dunstify -u normal -h string:x-dunst-stack-tag:xkb 'Keyboard: EN'
fi
