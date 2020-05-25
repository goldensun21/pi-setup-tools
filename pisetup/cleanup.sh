#!/bin/bash
# This is a cleanup script to be run if any errors happen during development


#ask for previously attempted username
echo "What was the most previously attempted username?"
read NEWU
echo

#ask for the previously attempted hostname
echo "What was the most previously attempted hostname?"
read NEWHOSTNAME

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



sleep 1

echo "Cleaning complete"
echo
