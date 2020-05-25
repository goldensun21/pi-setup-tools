#!/bin/bash

# this script is designed to be run with the raspberry pi boot drive
# inserted after flashing via etcher or some other utility. It will
# create an empty ssh file to enable ssh upon boot and ask for your
# ssid and wlan password to create the wpa_supplicant.conf file.

#program description
echo
echo "Raspberry Pi pre-boot ssh configuration utility"
echo
sleep 2

#cd to boot drive directory
cd /Volumes/boot

#create empty ssh file
sudo touch ssh

#create wpa_supplicant.conf file
sudo touch wpa_supplicant.conf

#ask for wifi country code
echo
echo "Please enter your Wi-Fi country code (i.e. US, GB, DE, etc...)"
read WIFIC

sleep .5

#ask for ssid
echo
echo "Please enter your SSID - name of your wireless network"
read USSID

sleep .5

#ask for ssid password
echo
echo "Please enter the password for this wireless network"
read -s SSIDP

sleep .5
echo
echo "Thank you"

sudo cat <<EOF > wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=$WIFIC

network={
     ssid="$USSID"
     psk="$SSIDP"
     key_mgmt=WPA-PSK
}
EOF

sleep 1

#diskutil umount /Volumes/boot

#results and eject
echo
echo "The configuration files have been written. Please eject the"
echo "SD card and insert it into the Raspberry Pi. Wait about 1.5"
echo "minutes, then run piconfig script as root."
