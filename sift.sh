#!/bin/bash

first=$(echo $1 | head -c 1) #set to first letter of inputted package
url=http://ftp.us.debian.org/debian/pool/main/$first/$1/ #set to ftp url | to change mirror locaton, change ftp.us.debian.org to one from here https://packages.debian.org/bullseye/all/neofetch/download
if [[ $(w3m $url | grep found | awk '{ print$1 }') == "The" ]] #if package not found
then
    echo "'$1' Not Found"
    exit
fi
w3m $url | grep .deb | awk '{ print$3 }' #display available packages
read -p "Enter Package Name > " pacname #read real package name
echo "Downloading..."
wget -O /tmp/package.deb $url/$pacname &> /dev/null #download deb package to /tmp/
echo "Converting to Void Package..."
xdeb -Sde /tmp/package.deb &> /dev/null #convert deb package to void package
xbps-install -R binpkgs $(xdeb -Sde /tmp/package.deb | sed 's/.....$//' ) #install created void package
rm /tmp/package.deb #delete deb package
echo "Done!"