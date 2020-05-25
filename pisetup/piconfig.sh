#!/bin/bash

# This script is to sign in to the raspberry pi the first time and inject
# the setup script.


#description
echo
echo "This script will send and execute the pi setup script with your new credentials"
echo
sleep 2

#display arp
echo "The IP addresses on your network will now be displayed. Locate your Pi's IP address."
echo
sleep 3
arp -a
echo

#select pi's IP address
echo "Please enter your Pi's IP address as it is shown above"
read PIIP
sleep 1

#get new desired root password (this is fairly safe because root user will be disabled anyway) and pass to expsetup.exp
echo
echo "Please enter a temporary root password for the pi (note that this account will be disabled)"
read -s ROOTP

sed -i '' "1,/ROOTEP/{s/set ROOTEP.*/set ROOTEP $ROOTP/;}" ./expsetup.exp

#get new desired username and pass to expsetup.exp and setup.sh
echo
echo "Please enter a new username for the pi"
read NEWU
sed -i '' "s/NEWEU/$NEWU/" ./setup.sh
sed -i '' "s/set NEWEU.*/set NEWEU $NEWU/" ./expsetup.exp

#get new desired password and pass to expsetup.exp
echo
echo "Please enter a new password for this account"
read -s NEWP
sed -i '' "s/set NEWEP.*/set NEWEP $NEWP/" ./expsetup.exp

#get new hostname
echo
echo "Enter a new hostname. Press enter if you want to keep the"
echo "default hostname of raspberrypi"
read NEWHOSTNAME
if test -z "$NEWHOSTNAME"
then
        sed -i '' "s/NEWHOST/raspberrypi/" ./setup.sh
else
        sed -i '' "s/NEWHOST/$NEWHOSTNAME/" ./setup.sh
fi

#Now the pi will be sent the setup script and logged into with expect
sed -i '' "s/$PIIP.*//" /var/root/.ssh/known_hosts
sed -i '' "s/$PIIP.*//" ~/.ssh/known_hosts

sleep 2

echo
echo "Sending setup script to pi to be run"
echo "Pi will reboot and then can be signed into with the new credentials"
echo
sleep 2
sed -i '' "s/set IPADDR.*/set IPADDR $PIIP/" ./expect.exp
expect ./expect.exp


#cleanup

sed -i '' "s/set ROOTEP.*/set ROOTEP xxx/" ./expsetup.exp
sed -i '' "s/set NEWEP.*/set NEWEP xxx/" ./expsetup.exp
sed -i '' "s/set NEWEU.*/set NEWEU xxx/" ./expsetup.exp
sed -i '' "s/set IPADDR.*/set IPADDR xxx/" ./expect.exp
sed -i '' "s/$NEWU/NEWEU/" ./setup.sh
sed -i '' "s/$NEWHOSTNAME/NEWHOST/" ./setup.sh
sed -i '' "s/raspberrypi/NEWHOST/2" ./setup.sh
sed -i '' "s/127.0.1.1     $NEWHOSTNAME/127.0.1.1     NEWHOST/" ./setup.sh
sed -i '' "s/127.0.1.1     raspberrypi/127.0.1.1     NEWHOST/" ./setup.sh
