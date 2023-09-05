#!/bin/sh

9 acme -f /mnt/font/DejaVuSans/14a/font -m /mnt/acme &
sleep 3
pgrep acmego | parallel kill -9
acmego &
