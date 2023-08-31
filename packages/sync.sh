#!/bin/bash

# Native 
pacman -Qnq > ~/Programming/SysInstaller/packages/native.pkglist.txt

# AUR
pacman -Qqm > ~/Programming/SysInstaller/packages/aur.pkglist.txt
