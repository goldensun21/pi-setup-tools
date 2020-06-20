# Raspberry Pi config tools

This set of scripts are tools to configure a Raspberry Pi on a Mac

The process:

  1. Write raspbian.img file to SD card with Etcher.
  2. Open terminal and navigate to this directory.
  3. Verify that the Volume "boot" is visible in Finder.
  4. Run preboot.sh as root ( $ sudo bash preboot.sh ).
  5. Eject SD card and insert into Pi. Wait for Pi to boot.
  6. Run piconfig.sh as root ( $ sudo bash piconfig.sh ).
  7. Wait for Pi to finish rebooting and log in as new user via ssh.
  8. Once you're back in, the Pi will begin an update.

The only programs you'll really need to run with sudo bash are:
  1. preboot.sh
  2. piconfig.sh
