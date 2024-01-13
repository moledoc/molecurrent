#!/bin/sh

set -e

walk -d $HOME/go/src > $HOME/jumper
walk -f $HOME/go/src | tee -a $HOME/jumper | parallel 'grep -nIH --color=none "^func\|^type" {} 2> /dev/null' >> $HOME/jumper
sed -i 's/^/* /' $HOME/jumper

