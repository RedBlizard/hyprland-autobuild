#!/usr/bin/env bash
mkdir /
# clone ISO sources and join the path:
git clone https://github.com/killajoe/EndeavourOS-Community-hyprland-ISO.git

# patch packages to not install Calamares packages from repository:
#patch EndeavourOS-ISO/packages.x86_64 < packages.x86_64.patch

# copy live session Wallpaper into ISO structure:
#cp livewall.png EndeavourOS-Community-hyprland-ISO/airootfs/root/
cp pacman.conf $BUILDDIR/EndeavourOS-Community-hyprland-ISO/airootfs/etc/pacman.conf
cp $BUILDDIR/EndeavourOS-Community-hyprland-ISO/packages-AUR.x86_64 /packages-AUR.x86_64

# run preperations inside ISO structure
cd $BUILDDIR/EndeavourOS-Community-hyprland-ISO

# Copy packages from Build Calamares git packages into iso structure:
#cp /home/build/packages/* airootfs/root/packages/

# Get mirrorlist for offline installs
mkdir "$BUILDDIR/EndeavourOS-Community-hyprland-ISO/airootfs/etc/pacman.d"
wget -qN --show-progress -P "$BUILDDIR/EndeavourOS-Community-hyprland-ISO/airootfs/etc/pacman.d/" "https://raw.githubusercontent.com/endeavouros-team/EndeavourOS-ISO/main/mirrorlist"

# Get wallpaper for installed system
wget -qN --show-progress -P "$BUILDDIR/EndeavourOS-Community-hyprland-ISO/airootfs/root/" "https://raw.githubusercontent.com/endeavouros-team/endeavouros-theming/master/backgrounds/endeavouros-wallpaper.png"

# Make sure build scripts are executable
chmod +x "$BUILDDIR/EndeavourOS-Community-hyprland-ISO/"{"mkarchiso","run_before_squashfs.sh"}

# building AUR packages and make sur esaving them into airootfs/root/packages:
echo "%wheel         ALL = (ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

pacman -Syy
pacman -S --noconfirm --needed git yay
useradd -m -G wheel -s /bin/bash build

echo PKGDEST=/home/build/packages >> /etc/makepkg.conf
mkdir /home/build/packages
chown -R build:build /home/build/packages

#sudo -u build yay -S --noconfirm cava
#sudo -u build yay -S --noconfirm nwg-look-bin
sudo -u build yay -S --noconfirm wlogout
#sudo -u build yay -S --noconfirm swww
#sudo -u build yay -S --noconfirm networkmanager-dmenu-bluetoothfix-git
sudo cp /home/build/packages/* $BUILDDIR/EndeavourOS-Community-hyprland-ISO/airootfs/root/packages

# Build liveuser skel
sudo chown -R build:build $BUILDDIR/EndeavourOS-Community-hyprland-ISO/airootfs/root/endeavouros-skel-liveuser
cd $BUILDDIR/EndeavourOS-Community-hyprland-ISO/airootfs/root/endeavouros-skel-liveuser
sudo -u build makepkg -f
