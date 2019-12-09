# Loads bash completion scripts, if they exist. To be sourced from your
# `.bash_profile`.

## MacOS
if [[ $(which brew) ]]; then
	dir=$(brew --prefix)/etc/bash_completion.d

	if [[ -d $dir ]]; then
		for script in "$dir"/*; do
			. "$script"
		done
	fi
fi
