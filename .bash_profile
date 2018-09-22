
# Run subsequent commands only from an interactive shell.
[[ $- != *i* ]] && return

. ~/.bashrc

# Replace shell with tmux, if not in a remote shell or an existing tmux session.
if [[ -z $TMUX ]] && [[ -z $SSH_CLIENT ]]; then
    if [[ $(tmux ls -F '#{?session_attached,yes,no}' | grep no) ]]; then
        exec tmux attach
    else
        exec tmux new
    fi
fi
