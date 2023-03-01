#!/bin/bash

first=$(echo $1 | head -c 1) #set to first letter of inputted package
url=http://ftp.us.debian.org/debian/pool/main/$first/$1/ #set to ftp url
w3m $url | grep .deb | awk '{ print$3 }' #display available packages
read -p "Enter Package Name > " pacname #read real package name
wget -O /tmp/package.deb $url/$pacname #download deb package to /tmp/
xdeb -Sde /tmp/package.deb #convert deb package to void package
xbps-install -R binpkgs $(xdeb -Sde /tmp/package.deb | awk '{print $7}' | tr -d '`' | sed 's/\`//g' | tail -n 1) #install created void package
rm /tmp/package.deb #delete deb package

echo "Done!"
