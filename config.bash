
function config {(
    local file=$PREFIX/src/$REPO/default.config
    umask 0077

    case "$1" in
    '--add')
        if [[ ! -f $PREFIX/etc/$NAME/config ]]; then
            mkdir -p "$PREFIX/etc/$NAME"
            cp "$PREFIX/src/$REPO/default.config" "$PREFIX/etc/$NAME/config"
        fi ;;
    esac

    if [[ -f $PREFIX/etc/$NAME/config ]]; then
        file=$PREFIX/etc/$NAME/config
    fi

    git config -f "$file" "$@"
)}

# Reads an input value if the requested config value isn't set.
function read-config {
    if [[ -z $(config --name-only -l | grep -E "^$1$") ]]; then
        local value
        printf '%s%s%s' "$2" "${3:+ [$3]}" ': '
        read value
        value="${value:-$3}"
        config --add "$1" "$value"
    fi
}
