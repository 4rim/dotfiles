#!/bin/zsh
# Backup script. Saves package list, /home/arim and /etc to a tarball.
# Should run daily at midnight.

today=$(date +%d-%m-%Y-%H:%M:%S)
backupdir="/backup/"
packages="/home/arim/dotfiles/packages.txt"

sudo pacman -Q > $packages

sudo tar --exclude="/home/arim/.cache" -zcvpf $backupdir/$today.tar.gz ~  /etc
sudo find $backupdir/* -mtime +30 -exec rm {} \;
