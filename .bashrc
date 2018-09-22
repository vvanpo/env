# Non-interactive remote shells may still source .bashrc, so we test for an
# interactive shell and exit otherwise.
[[ -z $PS1 ]] && return

