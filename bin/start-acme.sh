#!/bin/sh

acme -f /mnt/font/DejaVuSansMono/14a/font -m /mnt/acme &
pgrep "acme-lsp" | parallel 'kill -9 {}'
ACME_LSP_CONFIG=$HOME/.config/acme-lsp/config.toml acme-lsp -hidediag

# some useful/helpful commands/comments
# acme-lsp -showconfig
# ACME_LSP_CONFIG=$HOME/.config/acme-lsp/config.toml
# go lsp: acme-lsp -server '([/\\]go\.mod)|([/\\]go\.sum)|(\.go)$:gopls serve' -hidediag &
# c lsp: acme-lsp -server '(\.h)|(\.c)|(\.cpp)|(\.cc)|(\.def)$:ccls' -hidediag  &

# pgrep acmego | parallel kill -9
# acmego &
