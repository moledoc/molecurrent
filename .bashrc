# aliases
alias ls="ls -F"
alias dir="dir -F"
alias vdir="vdir -F"
alias acme="start-acme.sh &"

# push some dirs for `dirs`
alias dirs="dirs -l -p"
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
ssh-add $HOME/.ssh/git_key > /dev/null
