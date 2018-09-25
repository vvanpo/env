# Defines config function for manipulating the environment configuration.
# Depends on NAME, REPO, and PREFIX variables.

function config {(
	local file=$PREFIX/src/$REPO/default.config

	case "$1" in
		'--add')
			if [[ ! -f $PREFIX/etc/$NAME/config ]]; then (
				umask 0077
				mkdir -p "$PREFIX/etc/$NAME"
				set -x
				cp "$PREFIX/src/$REPO/default.config" "$PREFIX/etc/$NAME/config"
			) fi ;;
		'--install')
			"$PREFIX/src/$REPO/install"
			return ;;
	esac

	if [[ -f $PREFIX/etc/$NAME/config ]]; then
		file=$PREFIX/etc/$NAME/config
	fi

	git config -f "$file" "$@"
)}
