#!/bin/bash

# Checking for root
if [[ $(/usr/bin/id -u) -ne 0 ]]; 
then
    echo "Not running as root"
    exit
fi

# Installing depencies
pacman -S --needed base-devel dkms git

# Driver installation
cd ~/Downloads
git clone https://github.com/aircrack-ng/rtl8812au.git
cd rtl88*
make dkms_install