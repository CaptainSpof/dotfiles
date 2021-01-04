#!/usr/bin/env zsh

alias e="emacsclient"
alias ne='emacs -nw'
ediff() { e --eval "(ediff-files \"$1\" \"$2\")"; }
