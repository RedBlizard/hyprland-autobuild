#!/bin/sh
# building AUR packages and make sur esaving them into airootfs/root/packages:
echo "%wheel         ALL = (ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

pacman -Syy
pacman -S --noconfirm --needed git yay
useradd -m -G wheel -s /bin/bash build

echo PKGDEST=/home/build/packages >> /etc/makepkg.conf
mkdir /home/build/packages
chown -R build:buil /home/build/packages
# Build liveuser skel
#get_pkg() {
#    pacman -Syw $1 --noconfirm --cachedir EndeavourOS-Community-hyprland-ISO/airootfs/root/packages
#}

#get_pkg eos-settings-plasma

#pacman -Syddw --noconfirm --cachedir EndeavourOS-Community-hyprland-ISO/airootfs/root/packages eos-settings-plasma
chown -R build:build EndeavourOS-Community-hyprland-ISO/airootfs/root/endeavouros-skel-liveuser
cd EndeavourOS-Community-hyprland-ISO/airootfs/root/endeavouros-skel-liveuser
sudo -u build makepkg -f
cd /
sudo -u  build yay -S --noconfirm - < /packages-AUR.x86_64
cp /home/build/packages/* EndeavourOS-Community-hyprland-ISO/airootfs/root/packages/
