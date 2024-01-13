#!/bin/sh
xterm -e "echo \"$PATH\" | tr \":\" \"\n\" | parallel ls | sort | uniq | fzf -i --no-color >> /tmp/launch"
$(tail -n 1 /tmp/launch)
