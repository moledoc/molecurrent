alias ls="ls --color=none -F"
alias dir="dir --color=none -F"
alias vdir="vdir --color=none -F"
alias grep="grep --color=none"
alias pgrep="pgrep --color=none"
alias egrep="egrep --color=none"
alias fgrep="fgrep --color=none"

alias acme="acme -f /mnt/font/DejaVuSans/14a/font -m /mnt/acme; acmego &"

branch(){
        git branch 2> /dev/null 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(branch)\$ '

PLAN9=$HOME/plan9
PATH=$PATH:$HOME/go/bin:$PLAN9/bin

