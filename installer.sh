#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; 
then
    echo "Not running as root"
    exit
fi

# Initial update
pacman -Syyu

# Setting up Arch mirrors and repos
wget https://github.com/archlinux/svntogit-packages/raw/packages/pacman-mirrorlist/trunk/mirrorlist -O /etc/pacman.d/mirrorlist-arch
cat ./packages/mirrors.txt >> /etc/pacman.d/mirrorlist-arch
cat ./packages/repositories.txt >> /etc/pacman.conf
pacman -Syyu

# Native packages
pacman -S --needed - < ./packages/pkglist.txt
# Aur packages
yay -S --needed - < ./packages/aur.pkglist.txt

# OhMyZsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# Powerlevel10k Theme
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
cp ./configs/p10k.zsh ~/.p10k.zsh

# Nvidia & Gigabyte drivers
echo -n "Install Nvidia & Gigabyte drivers? [Yes/no]: "
read install
if [ install == "Yes" ];
then
    pacman -S nvidia-settings
    yay -S opengigabyte-meta
    cp ./scripts/fans.sh ~
fi

# Other
cp ./other/arch-zsh-cheatsheet.txt ~/Documents

echo "Reboot now?"
echo -n "[Yes/No]: "
read rebooting
if [ rebooting == "No" ];
then
    exit
fi
else if [ rebooting == "Yes"];
then
    reboot
fi