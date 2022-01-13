function gitpu {
	git push -u origin "$(git branch --show-current)"
}

function l {
	exa -al --color-scale --color always "$@" | less -FX
}

eval "$(zoxide init bash)"
