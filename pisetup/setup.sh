#!/bin/bash
#this script needs to be run as root (needed to change user names, etc)

#check to see if user is running this as root
if [ "$(whoami)" != "root" ]; then
        echo "Please log in as root to run this script"
        exit 255
fi

#install expect
sudo apt-get install expect -y

#sleep 2s
sleep 2

#add the new user
useradd -m NEWEU

#pause 1s
sleep 1

#add user to sudoers
usermod -aG sudo NEWEU

#pause for account creation
sleep 1

#copy the update.sh script to the new user's home directory
cp /home/pi/update.sh /home/NEWEU

#add update script to .bashrc
echo "sudo bash /home/NEWEU/update.sh"\
>> /home/NEWEU/.bashrc

#change the hostname
sed -i 's/raspberrypi/NEWHOST/' /etc/hostname
sed -i 's/127.0.1.1.*/127.0.1.1     NEWHOSTNEWHOSTNEWHOST/' /etc/hosts

#pause 1s
sleep 1

#refer to expsetup.exp to change root and new user's passwords
expect ./expsetup.exp

#disable pi and root users
passwd -l pi
passwd -l root

#disable pi and root login
usermod -s /sbin/nologin root
usermod -s /sbin/nologin pi
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

#remove the pi user directory
rm -r /home/pi

#update and upgrade
#apt-get update
#apt-get upgrade -y

#alert for restart
echo "New user has been created and password has been changed. Users pi and root have been disabled. Pi will restart in 5 seconds"
sleep 5

#restart for changes to take effect
reboot now
