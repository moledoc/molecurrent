#!/bin/sh

su -c "
apt install -y xorg build-essential libx11-dev libxt-dev libfontconfig1-dev libxtst-dev git openbox chromium fuse3 vlc spacefm-gtk3 wpagui gnome-backgrounds mate-backgrounds feh dunst

wget https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz
rm go1.20.2.linux-amd64.tar.gz

git clone https://github.com/9fans/plan9port.git $HOME/plan9
./plan9/INSTALL

git clone https://github.com/9fans/go.git $HOME/9fansgo
go install $HOME/9fansgo/acme/acmego
go install $HOME/9fansgo/acme/Watch

go install github.com/google/codesearch/cmd/...@latest
cindex $HOME/go/src /usr/local/go

su -c "ln -s bin/* /usr/local/bin/"

git config --global color.ui false
git config --global user.name "meelis utt"
git config --global user.email "meelis.utt@gmail.com"

ssh-keygen -t rsa -b 4096 -C "meelis.utt@gmail.com" -f $HOME/.ssh/git_key -P ""

mv $HOME/.bashrc $HOME/.bashrc_orig
ln -s ./.bashrc $HOME/.bashrc
ln -s ./.bash_profile $HOME/.bash_profile

mkdir -p $HOME/.config/openbox
ln -s ./.config/openbox/* $HOME/.config/openbox/

su -c "systemctl reboot"
