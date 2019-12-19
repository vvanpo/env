# Loads bash completion scripts, if they exist. To be sourced from your
# `.bash_profile`.

## MacOS
if [[ $(which brew) ]]; then
	. "$(brew --prefix)/etc/bash_completion"
fi
