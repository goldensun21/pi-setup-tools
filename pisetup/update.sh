#!/bin/bash

#This is a one-time script to update and upgrade the Pi after the first reboot

echo
echo "As this is the first reboot with a new user, the Pi would"
echo "like to update. Please enter your sudo password to run"
echo "apt-get update and apt-get upgrade"
echo

me="$(whoami)"

sudo apt-get update
sudo apt-get upgrade -y

sed -i '/home/d' /home/$me/.bashrc

sudo rm /home/$me/update.sh
