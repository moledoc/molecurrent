#!/bin/bash

read -s -p "Root Password: " ROOT_PASSWORD

root_call(){
	printf "$ROOT_PASSWORD" | su -c "$1"
}

root_call "apt install -y xorg xterm build-essential libx11-dev libxt-dev libfontconfig1-dev libxtst-dev git openbox chromium fuse3 vlc spacefm-gtk3 wpagui gnome-backgrounds feh libnotify-bin qpdfview flameshot xdotool libxrandr-dev"

git clone https://github.com/moledoc/molecurrent.git
cd molecurrent
git checkout from-vm # TODO: remove once merged to main
git remote set-url origin git@github.com:moledoc/molecurrent.git

git clone https://git.suckless.org/slock
cd slock; cp config.def.h config.h; patch config.h ../.patches/slock.patch; root_call "make clean install"; cd ..

wget https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
root_call "rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz"
rm go1.20.2.linux-amd64.tar.gz

git clone https://github.com/9fans/plan9port.git $HOME/plan9
cd $HOME/plan9; ./INSTALL; cd -

git clone https://github.com/9fans/go.git $HOME/9fansgo
go install $HOME/9fansgo/acme/acmego
go install $HOME/9fansgo/acme/Watch

go install github.com/google/codesearch/cmd/...@latest
cindex $HOME/go/src /usr/local/go

root_call "ln -s $(pwd)/bin/* /usr/local/bin/"

git config --global color.ui false
git config --global user.name "meelis utt"
git config --global user.email "meelis.utt@gmail.com"

ssh-keygen -t rsa -b 4096 -C "meelis.utt@gmail.com" -f $HOME/.ssh/git_key -P ""

mv $HOME/.bashrc $HOME/.bashrc_orig
ln -s $(pwd)/.bashrc $HOME/.bashrc
ln -s $(pwd)/.bash_profile $HOME/.bash_profile
ln -s $(pwd)/.xinitrc $HOME/.xinitrc
ln -s $(pwd)/.Xresources $HOME/.Xresources

mkdir -p $HOME/.config/openbox
mkdir -p $HOME/.config/sxhkd
ln -s $(pwd)/.config/openbox/* $HOME/.config/openbox/
ln -s $(pwd)/.config/sxhkd/* $HOME/.config/sxhkd/
ln -s $(pwd)/.config/qpdfview/* $HOME/.config/qpdfview/

root_call "mkdir /mnt/acme /mnt/font;chmod 777 /mnt/acme /mnt/font /sys/class/backlight/intel_backlight/brightness"


(crontab -l; printf "*/5 * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) low-battery.sh\n") | crontab -

root_call "chmod 777 /usr/sbin/reboot /usr/sbin/shutdown"

rm $HOME/setup.bash
/usr/sbin/reboot
