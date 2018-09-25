# Installs dot-files and other initialization/configuration scripts/files into
# various places in the home directory.
# Depends on NAME, REPO, and PREFIX environment variables.

src=${PREFIX}/src/${REPO}
etc=${PREFIX}/etc/${NAME}
lib=${PREFIX}/lib/${NAME}
bin=${PREFIX}/bin

function install-file {
	if [[ ! -f $1 ]]; then
		>&2 echo $'\e[1;31m'"$1 is not a valid file."$'\e[m'
		return 1
	fi

	# Check if the target is a directory.
	if [[ ${2%%/} != $2 ]] || [[ -d $2 ]]; then
		local filename=$(basename "$1")
		mkdir -p "$2"
		rm -f "$2/$filename"
	elif [[ -e $2 ]]; then
		rm -f "$2"
	fi

	(set -x; cp "$1" "$2")
}

function install-url {(
	cd "$2"

	local cmd="$(eval "echo $1")"
	(set -x; curl -fsSLO "$cmd")
)}

# Takes an include section name and a path to install them in.
# Prints the list of installed paths.
function install-includes {(
	# Non-absolute paths are relative to the repository.
	cd "$src"

	IFS=$'\n' read -a files -d '' <<< "$(config --get-all "includes.${1}.file")"
	for file in "${files[@]}"; do
		install-file "$file" "${2}/"
		echo "${2}/$(basename "$file")"
	done

	IFS=$'\n' read -a urls -d '' <<< "$(config --get-all "includes.$1.url")"
	for url in "${urls[@]}"; do
		install-url "$url" "${2}/"
		echo "${2}/$(basename "$url")"
	done
)}

function install-git {
	rm -f ~/.gitconfig
	git config --global --add user.name "$(config --get user.name)"
	git config --global --add user.email "$(config --get user.email)"

	if [[ $(config --get-all includes.etc.file | grep '^gitignore$') ]]; then
		git config --global --add core.excludesfile "${etc}/gitignore"
	fi
}

function install-bash {
	# Include scripts need knowledge of the folder hierarchy.
	local var
	for var in NAME REPO PREFIX; do
		echo "readonly ${var}=${!var}" >> ~/.bashrc
	done
	echo $'export NAME REPO PREFIX\n' >> ~/.bashrc

	# Install include scripts and source them.
	install-includes bash "$lib" | {
		IFS=$'\n' read -a paths -d ''
		for path in "${paths[@]}"; do
			echo ". $path" >> ~/.bashrc
		done
	}
}

# Reads an input value if the requested config value isn't set.
function request-config {
	local value

	if [[ -z $("$src/config" --name-only -l | grep -E "^${1}$") ]]; then
		printf $'\e[1;34m%s\e[m%s\e[1;34m%s\e[m' "$2" "${3:+ [$3]}" ': '
		read value
		value=${value:-$3}
		config --add "$1" "$value"
	fi
}

function install {
	request-config 'user.name' 'Full name'
	request-config 'user.email' 'E-mail'

	install-file "${src}/config" "${bin}/"
	install-includes '~' ~ > /dev/null
	install-includes etc "$etc" > /dev/null
	install-bash
	install-git
}