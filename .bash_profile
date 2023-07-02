#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.bashenv ]] && . ~/.bashenv
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
