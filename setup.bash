#!/bin/bash

user=${whoami}

read -s -p "Root Password: " ROOT_PASSWORD

root_call(){
	printf "$ROOT_PASSWORD" | su -c "$1"
}

# apt update && apt upgrade && 
root_call "apt install --fix-missing -y
xorg xterm build-essential 
libx11-dev libxext-dev libxt-dev
libfontconfig1-dev libxtst-dev libxinerama-dev libxft-dev 
xdotool libxrandr-dev xautolock xinput xclip parallel 
doas 
rfkill network-manager 
git 
chromium 
sxhkd 
fuse3 ntfs-3g 
alsa-utils 
vlc 
dunst 
keepassxc 
spacefm-gtk3
gnome-backgrounds feh 
flameshot 
thunderbird 
okular scribus calibre
pandoc texlive-full
"
read -p "Press enter to continue"

git clone https://github.com/moledoc/molecurrent.git
cd molecurrent
molecurrent_path=$(pwd)
git remote set-url origin git@github.com:moledoc/molecurrent.git

# git clone https://git.suckless.org/slock
# cd slock; cp config.def.h config.h; patch config.h ../.patches/slock.patch; root_call "make clean install"; cd -

# git clone https://git.suckless.org/dmenu
# cd dmenu; cp config.def.h config.h; patch config.h ../.patches/dmenu_config.patch; patch dmenu.c ../.patches/dmenu_c.patch; root_call "make clean install"; cd -

wget https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
root_call "rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz"
rm go1.20.2.linux-amd64.tar.gz

root_call "git clone https://github.com/9fans/plan9port.git /usr/local/plan9"
root_call "cd /usr/local/plan9; ./INSTALL; cd -"
root_call "cd /usr/local/plan9/bin; patch web ${molecurrent_path}/.patches/plan9-bin-web.patch; cd -"
root_call "mkdir /mnt/acme /mnt/font; /usr/local/plan9/bin/9 chmod 777 /mnt/acme /mnt/font"
 
git clone https://github.com/9fans/go.git 9fansgo
cd 9fansgo/acme/acmego; /usr/local/bin/go install; cd -
cd 9fansgo/acme/Watch; /usr/local/bin/go install; cd -

git clone https://github.com/9wm/9wm.git
cd 9wm; root_call "make install"; cd -

/usr/local/go/bin/go install github.com/google/codesearch/cmd/...@latest
cindex $HOME/go/src /usr/local/go

root_call "ln -s $(pwd)/bin/* /usr/local/bin/"

git config --global init.defaultBranch "main"
git config --global pager.log false
git config --global color.ui false
git config --global core.editor "ed"
read -p "Press enter to continue"

ssh-keygen -t rsa -b 4096 -C "meelis.utt@gmail.com" -f $HOME/.ssh/git_key -P ""

mv $HOME/.bashrc $HOME/.bashrc.orig
ln -s $(pwd)/.bashrc $HOME/.bashrc
ln -s $(pwd)/.bash_profile $HOME/.bash_profile
ln -s $(pwd)/.xinitrc $HOME/.xinitrc
ln -s $(pwd)/.Xresources $HOME/.Xresources

mkdir -p $HOME/.config/sxhkd
mkdir -p $HOME/.config/qpdfview
ln -s $(pwd)/.config/sxhkd/* $HOME/.config/sxhkd/
ln -s $(pwd)/.config/qpdfview/* $HOME/.config/qpdfview/

# mnt points for acme
root_call "mkdir /mnt/acme /mnt/font;chmod 777 /mnt/acme /mnt/font"

# doas setup
root_call "printf \"permit nopass ${user} as root cmd /usr/sbin/reboot\npermit nopass ${user} as root cmd /usr/sbin/shutdown\npermit ${user} as root\npermit nopass ${user} as root cmd /usr/sbin/dhclient\" > /etc/doas.conf"

# allow user to change brightness
root_call "printf 'ACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"intel_backlight\", RUN+=\"/bin/chgrp video /sys/class/backlight/%k/brightness\"\nACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"intel_backlight\", RUN+=\"/bin/chmod g+w /sys/class/backlight/%k/brightness\"' > /etc/udev/rules.d/backlight.rules" 
root_call "usermod -a -G video ${user}

#root_call "chmod 777 /usr/sbin/reboot /usr/sbin/shutdown"
#root_call "chmod 777 /sys/class/backlight/intel_backlight/brightness"
#root_call "chmod 777 /sys/class/power_supply/BAT0/capacity"

# make apt colorless
su -c "printf 'Binary::apt::DPkg::Progress-Fancy \"false\";\nBinary::apt::APT::Color \"false\";' > /etc/apt/apt.conf.d/99nocolor"

# battery warning cron
#(crontab -l; printf "*/5 * * * * ${user} /usr/local/bin/low-battery.sh\n") | crontab -

rm $HOME/setup.bash
/usr/sbin/reboot
