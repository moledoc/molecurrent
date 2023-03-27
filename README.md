
## Progrms

as root

```{.sh}
su -c "
apt install -y xorg build-essential libx11-dev libxt-dev libfontconfig1-dev libxtst-dev git openbox chromium fuse3

wget https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz
rm go1.20.2.linux-amd64.tar.gz
"

printf "
plumber &
openbox-session
" >> .xinitrc

printf "xterm*faceName: DejaVuSansMono
xterm*faceSize: 12" >> .Xresources

cd $HOME
git clone https://github.com/9fans/plan9port.git plan9
cd plan9
./INSTALL
printf "PLAN9=\$HOME/plan9
PATH=\$PATH:\$PLAN9/bin" >> .profile
cd $HOME

git clone https://github.com/9fans/go.git 9fansgo
cd 9fansgo/acme/acmego; go install; cd -
cd 9fansgo/acme/Watch ; go install; cd -

go install github.com/google/codesearch/cmd/...@latest
cindex $HOME/go/src /usr/local/go

mkdir $HOME/bin
printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
9 grep -i -n '^func (\([^)]+\) )?'\$search'\(' *.go /dev/null
" > $HOME/bin/c

printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
csearch -n -f '\.go\$' '^func (\([^)]+\) )?'\$search'\('
" > $HOME/bin/cf

printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
9 grep -i -n '^type '\$search' ' *.go /dev/null
" > $HOME/bin/t

printf "#\!/bin/sh
search=\$1
test -n \$search && search=\$(cat -)
csearch -n -f '\.go\$' '^type '\$seach
" > $HOME/bin/ct

chmod +x bin/*

git config --global color.ui false

printf "
alias ls=\"ls --color=none -1F\"
alias dir=\"dir --color=none -1F\"
alias vdir=\"vdir --color=none -1F\"
alias grep=\"grep --color=none\"
alias pgrep=\"pgrep --color=none\"
alias egrep=\"egrep --color=none\"
alias fgrep=\"fgrep --color=none\"

alias acme=\"acme -f /mnt/font/DejaVuSans/14a/font -m /mnt/acme\; acmego &"
" > .bashrc

exit
```


# TODO:

* openbox menu system

* wifi
* logout
* login screen
* sound
* language input
* battery
* datetime
* runlauncher
* (panel)
