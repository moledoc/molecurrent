#!/bin/sh

acme -f /mnt/font/DejaVuSansMono/14a/font -m /mnt/acme &
sleep 3
pgrep acmego | parallel kill -9
acmego &
