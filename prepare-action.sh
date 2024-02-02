#!/usr/bin/env bash

# clone ISO sources and join the path:
git clone https://github.com/killajoe/EndeavourOS-Community-hyprland-ISO.git

# patch packages to not install Calamares packages from repository:
#patch EndeavourOS-ISO/packages.x86_64 < packages.x86_64.patch

# copy live session Wallpaper into ISO structure:
cp livewall.png EndeavourOS-Community-hyprland-ISO/airootfs/root/
cp pacman.conf EndeavourOS-Community-hyprland-ISO/airootfs/etc/pacman.conf
#cp EndeavourOS-Community-hyprland-ISO/packages-AUR.x86_64 /packages-AUR.x86_64

# run preperations inside ISO structure

# Get mirrorlist for offline installs
mkdir "EndeavourOS-Community-hyprland-ISO/airootfs/etc/pacman.d"
wget -qN --show-progress -P "EndeavourOS-Community-hyprland-ISO/airootfs/etc/pacman.d/" "https://raw.githubusercontent.com/endeavouros-team/EndeavourOS-ISO/main/mirrorlist"

# Get wallpaper for installed system
wget -qN --show-progress -P "EndeavourOS-Community-hyprland-ISO/airootfs/root/" "https://raw.githubusercontent.com/endeavouros-team/endeavouros-theming/master/backgrounds/endeavouros-wallpaper.png"

# Make sure build scripts are executable
chmod +x "EndeavourOS-Community-hyprland-ISO/"{"mkarchiso","run_before_squashfs.sh"}
