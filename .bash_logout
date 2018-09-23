# Clear the screen when leaving the top-level console.
if [[ $SHLVL == 1 ]]; then
	[[ $(which clear) ]] && clear
fi
