#!/usr/bin/zsh
# Weekly maintenance script that cleans pacman cache and updates mirrorlist.
# Should run at midnight on Sundays.

paccache -r
sudo reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
