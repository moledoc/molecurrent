
## Programs

as root

```{.sh}
su -c "
apt install -y xorg build-essential libx11-dev libxt-dev libfontconfig1-dev libxtst-dev git openbox chromium fuse3 vlc spacefm-gtk3 wpagui gnome-backgrounds mate-backgrounds feh dunst sxhkd

wget https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz
rm go1.20.2.linux-amd64.tar.gz
"

printf "
xrdb .Xresources
plumber &
feh --recursive --bg-fill --randomize /usr/share/backgrounds &
openbox-session
" > .xinitrc

printf "
xterm*faceName: DejaVuSansMono
xterm*faceSize: 12
" > .Xresources

cd $HOME
git clone https://github.com/9fans/plan9port.git plan9
cd plan9
./INSTALL
cd $HOME

git clone https://github.com/9fans/go.git 9fansgo
cd 9fansgo/acme/acmego; go install; cd -
cd 9fansgo/acme/Watch ; go install; cd -

go install github.com/google/codesearch/cmd/...@latest
cindex $HOME/go/src /usr/local/go

printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
9 grep -i -n '^func (\([^)]+\) )?'\$search'\(' *.go /dev/null
" > bin/c

printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
csearch -n -f '\.go\$' '^func (\([^)]+\) )?'\$search'\('
" > bin/cf

printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
9 grep -i -n '^type '\$search' ' *.go /dev/null
" > bin/t

printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
csearch -n -f '\.go\$' '^type '\$seach
" > bin/ct

chmod +x /usr/local/bin/f /usr/local/bin/cf /usr/local/bin/c /usr/local/bin/ct

git config --global color.ui false
git config --global user.name "meelis utt"
git config --global user.email "meelis.utt@gmail.com"

ssh-keygen -t rsa -b 4096 -C "meelis.utt@gmail.com" -f $HOME/.ssh/git_key -P ""

mv $HOME/.bashrc $HOME/.bashrc_orig
printf "
alias ls=\"ls --color=none -F\"
alias dir=\"dir --color=none -F\"
alias vdir=\"vdir --color=none -F\"
alias grep=\"grep --color=none\"
alias pgrep=\"pgrep --color=none\"
alias egrep=\"egrep --color=none\"
alias fgrep=\"fgrep --color=none\"

alias acme=\"acme -f /mnt/font/DejaVuSans/14a/font -m /mnt/acme\; acmego &\"

branch(){
        git branch 2> /dev/null 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\\ 1)/' # NOTE: remove the space manually
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1='${debian_chroot:+($debian_chroot)}\\u@\\h:\\w\$(branch)\\$ '
" > .bashrc

printf "PLAN9=\$HOME/plan9
PATH=\$PATH:\$HOME/go/bin:\$PLAN9/bin
setxkbmap -option \"caps:swapescape\" us
" >> .profile


su -c "systemctl reboot"

```


# TODO:

* openbox menu system
* ~~wifi~~ wpa_gui
* ~~logout~~ openbox --exit
	* to log out, use `openbox --exit`
* ~~login screen~~ startx in .bash_profile
* bluetooth
* runlauncher(?) see if necessary
* mounting
* datetime, sound, brightness, battery - handled by scripts
