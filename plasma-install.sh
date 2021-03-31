#!/usr/bin/env bash
#
# Plasma Desktop and Packages installation on fresh Arch Linux
# by MM <elkrien@gmail.com>
# License: GNU GPLv3
#


##### FUNCTIONS #####

# Pacman Installation function

func_install_pacman() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo
		echo " 		  Package "$1" is already installed"
		tput sgr0
	else
    		tput setaf 3
    		echo
    		tput sgr0
    		sudo pacman -S --noconfirm --needed $1
    	fi
}


# AUR installation function (from AUR)

func_install_aur() {
	if paru -Qi $1 &> /dev/null; then
		tput setaf 2
		echo
  		echo " 		  Package "$1" is already installed"
		tput sgr0
	else
    		tput setaf 3
    		echo
    		tput sgr0
    		paru -S --noconfirm --needed $1
    	fi
}

# Installation of AUR helper (paru)

aurhelperinstallation() {
	cd /tmp
	sudo rm -rf /tmp/paru*
	sudo curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/paru-bin.tar.gz &&
	tar -xvf paru-bin.tar.gz && cd paru-bin &&
	makepkg --noconfirm -si
	cd /tmp
}



##### LIST OF PACKAGES #####

# Pacman list

list_pacman=(
base-devel					# developer tools group
git							# the fast distributed version control system
xorg						# Xorg group - display server
plasma						# KDE Plasma group
sddm						# QML based X11 and Wayland display manager
plasma-wayland-session		# Plasma Wayland session
dolphin						# KDE File Manager
dolphin-plugins				# extra Dolphin plugins
dragon						# a multimedia player where the focus is on simplicity, instead of features
elisa						# a simple music player aiming to provide a nice experience for its users
gwenview 					# a fast and easy to use image viewer
kate						# advanced text editor
kbackup						# a program that lets you back up any directories or files ??????
kcalc						# scientific calculator
kcharselect					# character selector
kcolorchooser				# color chooser
konsole						# KDE's terminal emulator
kolourpaint					# Paint program
kompare						# graphical file differences tool
ktouch						# Touch Typing Tutor
ktorrent					# a powerful BitTorrent client for KDE
okular						# document viewer
partitionmanager			# a KDE utility that allows you to manage disks, partitions, and file systems
print-manager				# a tool for managing print jobs and printers
spectacle					# KDE screenshot capture utility
sweeper						# System Cleaner
cups						# CUPS Printing System - daemon package
system-config-printer		# a CUPS printer configuration tool and status applet
samba						# SMB Fileserver and AD Domain server
kdenlive					# a non-linear video editor for Linux using the MLT video framework
kdenetwork-filesharing		# properties dialog plugin to share a directory with the local network
kdegraphics-thumbnailers	# thumbnailers for various graphics file formats
ffmpegthumbs				# FFmpeg-based thumbnail creator for video files
kdeconnect					# adds communication between KDE and your smartphone
sshfs						# FUSE client based on the SSH File Transfer Protocol
kdeplasma-addons			# all kind of addons to improve your Plasma experience
gstreamer					# multimedia graph framework - core		
gst-libav					# multimedia graph framework - libav plugin
gst-plugins-bad				# multimedia graph framework - bad plugins
gst-plugins-base			# multimedia graph framework - base plugins	
gst-plugins-good			# multimedia graph framework - good plugins
gst-plugins-ugly			# multimedia graph framework - ugly plugins
krita						# edit and paint images
ark							# archiving tool
latte-dock 					# a dock based on Plasma Frameworks
reflector					# a module and script to retrieve and filter the latest Pacman mirror list
xdg-user-dirs-gtk			# creates user dirs and asks to relocalize them
pulseaudio					# a featureful, general-purpose sound server
pulseaudio-alsa				# ALSA Configuration for PulseAudio
pavucontrol					# PulseAudio Volume Control
alsa-firmware				# firmware binaries for loader programs in alsa-tools and hotplug firmware loader
alsa-lib					# an alternative implementation of Linux sound support
alsa-plugins				# additional ALSA plugins
alsa-utils					# ALSA utilities
playerctl					# mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others
libcups						# client libraries and headers for CUPS
nss-mdns					# glibc plugin providing host name resolution via mDNS (for wireless printer)
epson-inkjet-printer-escpr	# Epson printers drivers
avahi						# Service Discovery for Linux using mDNS/DNS-SD (for wireless printer)
openssh						# premier connectivity tool for remote login with the SSH protocol
ttf-roboto					# Google's signature family of fonts
ttf-roboto-mono				# a monospaced addition to the Roboto type family
noto-fonts					# Google Noto TTF fonts
ttf-fira-code 				# a monospaced fonts with programming ligatures
ttf-jetbrains-mono			# typeface fonts for developers, by JetBrains
ttf-ubuntu-font-family		# Ubuntu font family
ttf-nerd-fonts-symbols		# High number of extra glyphs from popular iconic fonts
awesome-terminal-fonts		# fonts/icons for powerlines
calibre						# ebook management application
simplescreenrecorder		# a feature-rich screen recorder that supports X11 and OpenGL
kitty						# a modern, hackable, featureful, OpenGL-based terminal emulator
htop						# interactive process viewer
neofetch					# a CLI system information tool written in BASH that supports displaying images
grub-customizer				# a graphical grub2 settings manager
fish						# smart and user friendly shell intended mostly for interactive use
libreoffice-fresh			# LibreOffice branch which contains new features and program enhancements
libreoffice-fresh-pl		# Polish language pack for LibreOffice Fresh
gufw						# uncomplicated way to manage your Linux firewall
discord						# all-in-one voice and text chat for gamers that's free and secure
intel-ucode					# Microcode update files for Intel CPUs
xclip						# command line interface to the X11 clipboard
wget						# network utility to retrieve files from the Web
ranger						# simple, vim-like file manager in terminal
ncdu						# disk usage analyzer with an ncurses interface
micro						# a modern and intuitive terminal-based text editor
bat							# cat clone with syntax highlighting and git integration
exa							# it is a ls command replacement
lolcat						# a command line tool to output rainbow of colors in Terminal
signal-desktop				# Signal Private Messenger for Linux
fd							# a simple, fast and user-friendly alternative to find
imagescan 					# EPSON Image Scan v3 front-end for scanners and all-in-ones
simplenote-electron-bin		# the simplest way to keep notes
ytop-bin					# a TUI system monitor written in Rust
bpytop						# a resource monitor that shows usage and stats for processor, memory, disks, network and processes
tlp							# Linux Advanced Power Management
# pulseaudio-bluetooth 		# Bluetooth support for PulseAudio
# bluez 					# daemons for the bluetooth protocol stack
# bluez-libs 				# deprecated libraries for the bluetooth protocol stack
# bluez-utils 				# Development and debugging utilities for the bluetooth protocol stack
# blueberry					# Bluetooth configuration tool
)


# AUR list

list_aur=(
bitwarden-bin				# a secure and free password manager for all of your devices
teams						# a Microsoft Teams for Linux
zoom						# Video Conferencing and Web Conferencing Service
skypeforlinux-stable-bin	# Skype for Linux
brave-bin					# Web browser that blocks ads and trackers by default
duf-bin						# Disk Usage/Free Utility (df replacement)
etcher-bin					# flash OS images to SD cards & USB drives, safely and easily
pamac-aur					# a Gtk3 frontend, Package Manager based on libalpm with AUR and Appstream support
spotify						# a proprietary music streaming service
typora						# MD editor
zoxide-bin					# cd replacement
starship-bin				# the cross-shell prompt for astronauts
#ant-dracula-gtk-theme		# Ant Dracula Theme for GTK 3.x
kora-icon-theme				# icon theme suitable for every desktop environment (dark and light versions, HiDPI support)
bibata-cursor-theme-bin		# mouse cursor theme
tela-icon-theme				# a flat colorful icon theme
ttf-ms-fonts				# core TTF fonts from Microsoft"
visual-studio-code-bin		# official binary version of Visual Studio Code (vscode)
)


##### MAIN SCRIPT #####

# Welcome message

clear
tput setaf 3
echo
echo "###############################################################################"
echo
echo " 			INSTALLATION OF PLASMA DESKTOP AND APPLICATIONS"
echo 
echo "###############################################################################"
echo
tput sgr0


# Setting fastest mirrors

tput setaf 3
echo
echo "### Finding fastest mirrors"
tput sgr0
sudo reflector -c Poland,Germany -a 12 --sort rate --save /etc/pacman.d/mirrorlist


# Installation of AUR helper

tput setaf 3
echo
echo "### Installation of AUR helper"
tput sgr0
aurhelperinstallation


# Installation of packages

count=0

for name in "${list_pacman[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "### Installation of package number "$count " " $name;tput sgr0;
	func_install_pacman $name
	echo
done

for name in "${list_aur[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "### Installation of package number "$count " " $name;tput sgr0;
	func_install_aur $name
	echo
done

# services activation

tput setaf 5;echo
echo
echo "###############################################################################"
echo
echo "			Enabling services (greeter, printers,TLP, etc.)"
echo 
echo;tput sgr0
sudo systemctl enable sddm																						# KDE greeter
sudo systemctl enable tlp.service																				# TLP - laptop power management
sudo systemctl enable cups.service 																				# printers
sudo sed -i 's/files mymachines myhostname/files mymachines/g' /etc/nsswitch.conf 								# nsswitch - first part
sudo sed -i 's/\[\!UNAVAIL=return\] dns/\[\!UNAVAIL=return\] mdns dns wins myhostname/g' /etc/nsswitch.conf 	# nsswitch - last part
sudo systemctl disable systemd-resolved.service 																# disable systemd-resolved (not working with avahi)
sudo systemctl enable avahi-daemon.service 																		# enable avahi (for wireless printer)
sudo systemctl enable fstrim.timer 																				# fstrim (sdd)
#sudo systemctl enable bluetooth.service																		# bluetooth - enable service
#sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf								# bluetooth settings
sudo touch /etc/sysctl.d/99-swappiness.conf 																	# set swappiness part 1
sudo bash -c 'echo "vm.swappiness=10" >> /etc/sysctl.d/99-swappiness.conf' 										# set swappiness part 2
sudo sed -i 's/^# --country France,Germany/--country Poland,Germany/' /etc/xdg/reflector/reflector.conf 		# reflector setting
sudo systemctl enable reflector.timer 																			# enabling reflector timer
grep -q "^Color" /etc/pacman.conf || sudo sed -i "s/^#Color$/Color/" /etc/pacman.conf							# make pacman and paru colorful - part 1
grep -q "ILoveCandy" /etc/pacman.conf || sudo sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf			# make pacman and paru colorful - part 2
echo /usr/local/bin/fish | sudo tee -a /etc/shells 																# change shell to fish - part 1
sudo chsh -s /bin/fish																							# change shell to fish - part 2

# End information

tput setaf 11;
echo
echo "###############################################################################"
echo
echo "		     KDE PLASMA AND ALL APLICATIONS HAVE BEEN INSTALLED"
echo
echo " 		    restart computer and start to rice Your new system :)"
echo
echo "###############################################################################"
echo;tput sgr0

