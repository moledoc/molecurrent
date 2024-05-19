#!/bin/sh

set -xe

vm=$(test "$1" = "vm" | printf "$1")

test "root" != "$(whoami)" && echo "run script as root" && exit 1
user=$(ls /home | tr -d '/')

self_soft=/usr/local
ext_soft=/opt

apt update && apt upgrade
apt install --fix-missing -y xorg xterm build-essential libx11-dev libxext-dev libxt-dev libfontconfig1-dev libxtst-dev libxinerama-dev libxft-dev xdotool libxrandr-dev xautolock xsecurelock xinput xclip parallel doas rfkill curl network-manager git chromium sxhkd fuse3 ntfs-3g alsa-utils vlc dunst keepassxc spacefm-gtk3 gnome-backgrounds feh flameshot okular fzf ccls
# pandoc texlive-full <- optional package
read -p "[INFO]: installation of packages done - Press enter to continue" _

runuser -u "${user}" -- git config --global init.defaultBranch "main"
runuser -u "${user}" -- git config --global pager.log false
runuser -u "${user}" -- git config --global color.ui false
runuser -u "${user}" -- git config --global core.editor "ed"
runuser -u "${user}" -- git config --global core.pager "cat"
runuser -u "${user}" -- git config --global push.autoSetupRemote "true"
read -p "[INFO]: git configuration done - Press enter to continue" _

runuser -u "${user}" -- git clone https://github.com/moledoc/molecurrent.git /home/${user}/molecurrent
cd /home/${user}/molecurrent
molecurrent_path=$(pwd)
runuser -u "${user}" -- git remote set-url origin git@github.com:moledoc/molecurrent.git
ln -s $(pwd)/bin/* "${self_soft}/bin/"
read -p "[INFO]: pulling molecurrent repo done - Press enter to continue" _

go_version=$(curl https://go.dev/dl/ | grep "class=\"download downloadBox\".*\.linux-amd64" | grep -o "go.*linux-amd64.tar.gz")
wget https://go.dev/dl/$go_version
rm -rf "${ext_soft}/go" && tar -C "${ext_soft}" -xzf $go_version
rm $go_version
read -p "[INFO]: installation of golang done - Press enter to continue" _

git clone https://github.com/9fans/plan9port.git "${ext_soft}/plan9"
cd "${ext_soft}/plan9/src/cmd/acme"; patch text.c ${molecurrent_path}/.patches/acme_text.patch; cd -
cd "${ext_soft}/plan9"; ./INSTALL; cd -
cd "${ext_soft}/plan9/bin"; patch web ${molecurrent_path}/.patches/plan9-bin-web.patch; cd -
read -p "[INFO]: pulled 9fans/plan9ports, patched acme and ran installation - Press enter to continue" _

git clone https://github.com/9fans/go.git "${ext_soft}/9fansgo"
cd "${ext_soft}/9fansgo/acme/Watch"; runuser -u ${user} -- ${ext_soft}/go/bin/go install -buildvcs=false; cd -
# cd "${ext_soft}/9fansgo/acme/acmego"; runuser -u ${user} -- ${ext_soft}/go/bin/go install; cd -
read -p "[INFO]: pulled 9fans/go and installed wanted programs - Press enter to continue" _

git clone https://github.com/9wm/9wm.git "${ext_soft}/9wm"
cd "${ext_soft}/9wm"
git apply --ignore-whitespace --ignore-space-change ${molecurrent_path}/.patches/9wm.patch
make install
cd -
read -p "[INFO]: pulled, patched and installed 9wm - Press enter to continue" _

git clone https://github.com/arnoldrobbins/9menu.git "${ext_soft}/9menu"
cd "${ext_soft}/9menu"; make 9menu; cd -
ln -s ${molecurrent_path}/9menu.cmds "${ext_soft}/9menu"
read -p "[INFO]: pulled 9menu and ran make - Press enter to continue" _

GO111MODULE=on go install github.com/fhs/acme-lsp/cmd/acme-lsp@latest
GO111MODULE=on go install github.com/fhs/acme-lsp/cmd/L@latest
GO111MODULE=on go install golang.org/x/tools/gopls@latest
read -p "[INFO]: go lsp for acme installed - Press enter to continue" _

git clone --depth=1 https://github.com/Simatwa/y2mate-api.git $HOME/y2mate-api
cd $HOME/y2mate-api; python3 -m venv .venv; ./venv/bin/python3 -m pip install .; cd -
read -p "[INFO]: y2mate-api installed - Press enter to continue" _

runuser -u ${user} -- test -e "/home/${user}/.bashrc" && mv /home/${user}/.bashrc /home/${user}/.bashrc.orig
runuser -u ${user} -- test -e "/home/${user}/.bashenv" && mv /home/${user}/.bashenv /home/${user}/.bashenv.orig
runuser -u ${user} -- test -e "/home/${user}/.bash_profile" && mv /home/${user}/.bash_profile /home/${user}/.bash_profile.orig
runuser -u ${user} -- test -e "/home/${user}/.xinitrc" && mv /home/${user}/.xinitrc /home/${user}/.xinitrc.orig
runuser -u ${user} -- test -e "/home/${user}/.Xresources" && mv /home/${user}/.Xresources /home/${user}/.Xresources.orig

runuser -u ${user} -- ln -s ${molecurrent_path}/.bashrc /home/${user}/.bashrc
runuser -u ${user} -- ln -s ${molecurrent_path}/.bashenv /home/${user}/.bashenv
runuser -u ${user} -- ln -s ${molecurrent_path}/.bash_profile /home/${user}/.bash_profile
runuser -u ${user} -- ln -s ${molecurrent_path}/.xinitrc /home/${user}/.xinitrc
runuser -u ${user} -- ln -s ${molecurrent_path}/.Xresources /home/${user}/.Xresources
runuser -u ${user} -- mkdir -p /home/${user}/.config/sxhkd
runuser -u ${user} -- ln -s $(pwd)/.config/sxhkd/* /home/${user}/.config/sxhkd/

runuser -u ${user} -- mkdir -p /home/${user}/.config/acme-lsp
runuser -u ${user} -- ln -s $(pwd)/.config/acme-lsp/* /home/${user}/.config/acme-lsp/
runuser -u ${user} -- ln -s $(pwd)/.config/haikyu.png /home/${user}/.config/haikyu.png
read -p "[INFO]: symlinks for config files done - Press enter to continue" _

# doas setup
printf "permit nopass ${user} as root cmd /usr/sbin/rebootnpermit nopass ${user} as root cmd /usr/sbin/shutdown\npermit nopass ${user} as root cmd /usr/sbin/dhclient\npermit ${user} as root\n" > /etc/doas.conf
read -p "[INFO]: doas configuration done - Press enter to continue" _

# allow user to change brightness
test -z "$vm" && printf 'ACTION=="add\", SUBSYSTEM==\"backlight\", KERNEL==\"intel_backlight\", RUN+=\"/bin/chgrp video /sys/class/backlight/%k/brightness\"\nACTION==\"add\", SUBSYSTEM==\"backlight\", KERNEL==\"intel_backlight\", RUN+=\"/bin/chmod g+w /sys/class/backlight/%k/brightness\"' > /etc/udev/rules.d/backlight.rules
usermod -a -G video ${user}
read -p "[INFO]: laptop brightness configuration done - Press enter to continue" _

# make apt colorless
printf 'Binary::apt::DPkg::Progress-Fancy "false";\nBinary::apt::APT::Color "false";' > /etc/apt/apt.conf.d/99nocolor
read -p "[INFO]: apt configuration done - Press enter to continue" _

runuser -u ${user} -- mkdir /home/${user}/.ssh
runuser -u ${user} -- ssh-keygen -t rsa -b 4096 -C "meelis.utt@gmail.com" -f /home/${user}/.ssh/git_key -P ""
read -p "[INFO]: ssh key generated - Press enter to continue" _

runuser -u "${user}" -- ${molecurrent_path}/bin/gh_bu.sh ${user} moledoc
cd /home/${user}/Documents/gh_bu/calc; cc -o ${self_soft}/bin/calc calc.c; cd -
cd /home/${user}/Documents/gh_bu/walk; cc -o ${self_soft}/bin/walk walk.c; cd -
cd /home/${user}/Documents/gh_bu/b64; cc -o ${self_soft}/bin/b64 b64.c; cd -
cd /home/${user}/Documents/gh_bu/pw; cc -o ${self_soft}/bin/pw pw.c; cd -

cd /home/${user}/Documents/gh_bu/av; ${ext_soft}/go/bin/go install; cd -
cd /home/${user}/Documents/gh_bu/ytf; ${ext_soft}/go/bin/go install ytfd.go; cc -o ${self_soft}/bin/ytf ytf.c; cd -
read -p "[INFO]: moledoc repos backed up and self software compiled - Press enter to continue" _

cd ${ext_soft}; chown -R ${user}:${user} *; cd -
cd ${self_soft}/bin; chown -R ${user}:${user} * && chmod +x *; cd -
read -p "[INFO]: ${ext_soft} and ${self_soft}/bin ownership transferred to ${user}; ${self_soft}/bin/* made into executables - Press enter to continue" _

read -p "[INFO]: setup done - Press enter to reboot" _
/usr/sbin/reboot
