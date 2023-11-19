# aliases
alias ls="ls -F"
# alias ls="ls --file-type"
alias dir="dir -F"
alias dirs="dirs -l -p"
alias vdir="vdir -F"

# if acmego doesn't start, try these commands
# 9 chmod 777 /mnt/acme /mnt/font
# 9 mount `namespace`/acme /mnt/acme
alias acme="start-acme.sh &"

# push some dirs for `dirs`
pushd -n $HOME > /dev/null
pushd -n $HOME/go/src > /dev/null
pushd -n $HOME/go/src/github.com > /dev/null
pushd -n $HOME/go/src/github.com/moledoc > /dev/null

# PS1
branch(){
        git branch 2> /dev/null 2> /dev/null | 9 sed "/^[^*]/d;s/\* (.*)/ (\1)/"
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1='$PWD$(branch) \$ '
eval $(ssh-agent -s); ssh-add $HOME/.ssh/git_key
