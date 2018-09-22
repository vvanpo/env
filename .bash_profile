. ~/.bashrc

## tmux
if [[ -z $TMUX ]] && [[ -z $SSH_CLIENT ]]; then
	if [[ $(tmux ls -F '#{?session_attached,yes,no}' | grep no) ]]; then
		exec tmux attach
	else
		exec tmux new
	fi
fi
