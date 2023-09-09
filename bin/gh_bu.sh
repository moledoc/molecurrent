#!/bin/sh
set -xe
usr="$1"
test -z "$usr" && echo "username expected" && exit 1
mkdir -p $HOME/Documents/gh_bu
cd $HOME/Documents/gh_bu
curl --silent "https://api.github.com/users/$usr/repos" | grep html_url | sort | 9 sed 's/.*"html_url": "(.*)",/\1/g' | uniq -u | parallel git clone {}
cd -
