#
# ~/.bash_profile
#

[[ -f ~/.bashenv ]] && . ~/.bashenv
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
