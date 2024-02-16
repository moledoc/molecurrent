#!/bin/sh

acme -f /mnt/font/DejaVuSansMono/14a/font -m /mnt/acme &
pgrep "acme-lsp" | parallel 'kill -9 {}'
acme-lsp -server '([/\\]go\.mod)|([/\\]go\.sum)|(\.go)$:gopls serve' &
# pgrep acmego | parallel kill -9
# acmego &
