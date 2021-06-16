function l {
	exa -al --color-scale --color always "$@" | less -FX
}

eval "$(zoxide init bash)"
