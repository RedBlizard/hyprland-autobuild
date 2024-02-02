#!/bin/sh
# building AUR packages and make sur esaving them into airootfs/root/packages:
echo "%wheel         ALL = (ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo PKGDEST=/usr/share/packages >> /etc/makepkg.conf
mkdir /usr/share/packages
pacman -Syy
pacman -S --noconfirm --needed git yay
useradd -m -G wheel -s /bin/bash build

# Build liveuser skel
#get_pkg() {
#    pacman -Syw "$1" --noconfirm --cachedir "EndeavourOS-Community-hyprland-ISO/airootfs/root/packages"
#}

#get_pkg "eos-settings-plasma"

#pacman -Syddw --noconfirm --cachedir "EndeavourOS-Community-hyprland-ISO/airootfs/root/packages" eos-settings-plasma
chown -R build:build "EndeavourOS-Community-hyprland-ISO/airootfs/root/endeavouros-skel-liveuser"
cd "EndeavourOS-Community-hyprland-ISO/airootfs/root/endeavouros-skel-liveuser"
sudo -u build makepkg -f

sudo -u  build yay -S --noconfirm - < /packages-AUR.x86_64
cp /usr/share/packages/* airootfs/root/packages/
