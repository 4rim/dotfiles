#!/usr/bin/sh

sitedir="$HOME/downloads/neocities-iwillneverbehappy/"

echo 'rsync -rtzvP "'$sitedir'" "root@marmeru.xyz:/var/www/marmeru/"'
rsync -rtzvP "$sitedir" "root@marmeru.xyz:/var/www/marmeru/"

