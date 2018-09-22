# Non-interactive remote shells may still source .bashrc.
[[ $- != *i* ]] && return

set -o vi

