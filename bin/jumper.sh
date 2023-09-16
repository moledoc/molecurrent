#!/bin/sh

# find $HOME/go/src -type d -not -path "*/\.git/*" > $HOME/jumper
# find $HOME/go/src -type f -not -path "*/\.git/*" | tee -a $HOME/jumper | parallel 'grep -nIH --color=none "^func\|^type"' {} >> $HOME/jumper

# 9 du -a $HOME/go/src | 9 grep -v "*.git" | awk '{print $2}' | tee $HOME/jumper | parallel '9 g "^func|^type" {}' 1>> $HOME/jumper 2> /dev/null 

walk $HOME/go/src | tee -a $HOME/jumper | parallel 'grep -nIH --color=none "^func\|^type" {} 2> /dev/null' >> $HOME/jumper

